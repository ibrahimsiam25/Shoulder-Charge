//
//  PlayerHeaderCell.swift
//  Shoulder-Charge
//

import UIKit
import SDWebImage

class PlayerHeaderCell: UICollectionViewCell {

    // MARK: - Outlets

    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var countryTitleLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var birthdateTitleLabel: UILabel!
    @IBOutlet weak var birthdateLabel: UILabel!

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyle()
        applyColors()
        applyLocalization()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let side = playerImageView.frame.width
        playerImageView.layer.cornerRadius = side / 2
        playerImageView.layer.masksToBounds = true
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            playerImageView.layer.borderColor = UIColor(named: "Border")?.cgColor
        }
    }

    // MARK: - Style (kept in code)

    private func applyStyle() {
        playerImageView.contentMode = .scaleAspectFill
        playerImageView.layer.borderWidth = 1.5

        layer.cornerRadius = 16
        layer.masksToBounds = true
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
    }

    private func applyColors() {
        playerImageView.layer.borderColor = UIColor(named: "Border")?.cgColor
        playerNameLabel.textColor     = UIColor(named: "Text Primary")
        leagueNameLabel.textColor     = UIColor(named: "Primary")
        countryTitleLabel.textColor   = UIColor(named: "Text Sec")
        countryLabel.textColor        = UIColor(named: "Text Primary")
        birthdateTitleLabel.textColor = UIColor(named: "Text Sec")
        birthdateLabel.textColor      = UIColor(named: "Text Primary")
    }

    private func applyLocalization() {
        countryTitleLabel.text   = L10n.PlayerDetails.country
        birthdateTitleLabel.text = L10n.PlayerDetails.birthdate
    }

    // MARK: - Configure

    func configure(with player: TennisPlayerModel, leagueName: String) {
        playerNameLabel.text  = player.playerName
        leagueNameLabel.text  = leagueName
        countryLabel.text     = player.playerCountry
        birthdateLabel.text   = player.playerBday
        playerImageView.sd_setImage(
            with: player.playerLogoURL,
            placeholderImage: UIImage(systemName: "person.circle.fill")
        )
    }
}
