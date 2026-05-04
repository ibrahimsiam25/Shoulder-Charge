//
//  PlayerStatSeasonCard.swift
//  Shoulder-Charge
//

import UIKit

class PlayerStatSeasonCard: UICollectionViewCell {

    // MARK: - Outlets

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var typeChipLabel: UILabel!
    @IBOutlet weak var rankTitleLabel: UILabel!
    @IBOutlet weak var rankValueLabel: UILabel!
    @IBOutlet weak var titlesTitleLabel: UILabel!
    @IBOutlet weak var titlesValueLabel: UILabel!
    @IBOutlet weak var wonTitleLabel: UILabel!
    @IBOutlet weak var wonValueLabel: UILabel!
    @IBOutlet weak var lostTitleLabel: UILabel!
    @IBOutlet weak var lostValueLabel: UILabel!
    @IBOutlet weak var hardTitleLabel: UILabel!
    @IBOutlet weak var hardWonLabel: UILabel!
    @IBOutlet weak var hardLostLabel: UILabel!
    @IBOutlet weak var clayTitleLabel: UILabel!
    @IBOutlet weak var clayWonLabel: UILabel!
    @IBOutlet weak var clayLostLabel: UILabel!
    @IBOutlet weak var grassTitleLabel: UILabel!
    @IBOutlet weak var grassWonLabel: UILabel!
    @IBOutlet weak var grassLostLabel: UILabel!
    @IBOutlet weak var dividerView: UIView!

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyle()
        applyColors()
        applyLocalization()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            cardView.layer.borderColor = UIColor(named: "Border")?.cgColor
        }
    }

    // MARK: - Style

    private func applyStyle() {
        cardView.layer.cornerRadius  = 12
        cardView.layer.borderWidth   = 1
        cardView.layer.masksToBounds = true
        typeChipLabel.layer.cornerRadius  = 8
        typeChipLabel.layer.masksToBounds = true
    }

    private func applyColors() {
        cardView.backgroundColor      = UIColor(named: "Surface")
        cardView.layer.borderColor    = UIColor(named: "Border")?.cgColor
        dividerView.backgroundColor   = UIColor(named: "Divider")
        seasonLabel.textColor         = UIColor(named: "Text Primary")
        typeChipLabel.textColor       = UIColor(named: "Primary")
        typeChipLabel.backgroundColor = UIColor(named: "Primary")?.withAlphaComponent(0.15)

        [rankTitleLabel, titlesTitleLabel, wonTitleLabel, lostTitleLabel,
         hardTitleLabel, clayTitleLabel, grassTitleLabel].forEach {
            $0?.textColor = UIColor(named: "Text Sec")
        }
        [rankValueLabel, titlesValueLabel, wonValueLabel, lostValueLabel,
         hardWonLabel, hardLostLabel, clayWonLabel, clayLostLabel,
         grassWonLabel, grassLostLabel].forEach {
            $0?.textColor = UIColor(named: "Text Primary")
        }
    }

    private func applyLocalization() {
        rankTitleLabel.text   = L10n.PlayerDetails.rank
        titlesTitleLabel.text = L10n.PlayerDetails.titles
        wonTitleLabel.text    = L10n.PlayerDetails.matchesWon
        lostTitleLabel.text   = L10n.PlayerDetails.matchesLost
        hardTitleLabel.text   = L10n.PlayerDetails.hard
        clayTitleLabel.text   = L10n.PlayerDetails.clay
        grassTitleLabel.text  = L10n.PlayerDetails.grass
    }

    // MARK: - Configure

    func configure(with stat: PlayerStat) {
        seasonLabel.text      = "\(L10n.PlayerDetails.season) \(stat.season)"
        typeChipLabel.text    = " \(localizedType(stat.type)) "
        rankValueLabel.text   = "#\(stat.rank)"
        titlesValueLabel.text = stat.titles
        wonValueLabel.text    = stat.matchesWon
        lostValueLabel.text   = stat.matchesLost
        hardWonLabel.text     = stat.hardWon.isEmpty  ? "-" : stat.hardWon
        hardLostLabel.text    = stat.hardLost.isEmpty ? "-" : stat.hardLost
        clayWonLabel.text     = stat.clayWon.isEmpty  ? "-" : stat.clayWon
        clayLostLabel.text    = stat.clayLost.isEmpty ? "-" : stat.clayLost
        grassWonLabel.text    = stat.grassWon.isEmpty  ? "-" : stat.grassWon
        grassLostLabel.text   = stat.grassLost.isEmpty ? "-" : stat.grassLost
    }

    private func localizedType(_ type: String) -> String {
        switch type.lowercased() {
        case "singles": return L10n.PlayerDetails.singles
        case "doubles": return L10n.PlayerDetails.doubles
        default:        return type
        }
    }
}
