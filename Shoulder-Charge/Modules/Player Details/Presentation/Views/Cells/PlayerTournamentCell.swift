//
//  PlayerTournamentCell.swift
//  Shoulder-Charge
//

import UIKit

class PlayerTournamentCell: UICollectionViewCell {

    // MARK: - Outlets

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var surfaceChipLabel: UILabel!
    @IBOutlet weak var typeChipLabel: UILabel!
    @IBOutlet weak var prizeLabel: UILabel!

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyle()
        applyColors()
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
        surfaceChipLabel.layer.cornerRadius  = 8
        surfaceChipLabel.layer.masksToBounds = true
        typeChipLabel.layer.cornerRadius  = 8
        typeChipLabel.layer.masksToBounds = true
    }

    private func applyColors() {
        cardView.backgroundColor      = UIColor(named: "Surface")
        cardView.layer.borderColor    = UIColor(named: "Border")?.cgColor
        nameLabel.textColor           = UIColor(named: "Text Primary")
        seasonLabel.textColor         = UIColor(named: "Text Sec")
        typeChipLabel.textColor       = UIColor(named: "Primary")
        typeChipLabel.backgroundColor = UIColor(named: "Primary")?.withAlphaComponent(0.15)
        prizeLabel.textColor          = UIColor(named: "Primary")
    }

    // MARK: - Configure

    func configure(with tournament: PlayerTournament) {
        nameLabel.text     = tournament.name
        seasonLabel.text   = tournament.season
        typeChipLabel.text = " \(localizedType(tournament.type)) "
        prizeLabel.text    = tournament.prize

        let surfaceInfo = surfaceStyle(for: tournament.surface)
        surfaceChipLabel.text            = " \(tournament.surface) "
        surfaceChipLabel.textColor       = surfaceInfo.text
        surfaceChipLabel.backgroundColor = surfaceInfo.background
    }

    private func localizedType(_ type: String) -> String {
        switch type.lowercased() {
        case "singles": return L10n.PlayerDetails.singles
        case "doubles": return L10n.PlayerDetails.doubles
        default:        return type
        }
    }

    private func surfaceStyle(for surface: String) -> (text: UIColor, background: UIColor) {
        let s = surface.lowercased()
        let name: String
        if s.contains("clay") {
            name = "SurfaceClay"
        } else if s.contains("grass") {
            name = "SurfaceGrass"
        } else {
            name = "SurfaceHard"
        }
        let color = UIColor(named: name) ?? .systemBlue
        return (color, color.withAlphaComponent(0.15))
    }
}
