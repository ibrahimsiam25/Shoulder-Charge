//
//  PlayerHeaderCell.swift
//  Shoulder-Charge
//

import UIKit
import SDWebImage

class PlayerHeaderCell: UICollectionViewCell {

    // MARK: - Views

    private let playerImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 40
        iv.layer.borderWidth = 1.5
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let playerNameLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 18, weight: .bold)
        l.numberOfLines = 2
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let leagueNameLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13, weight: .semibold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let countryTitleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 11)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let countryLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let birthdateTitleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 11)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let birthdateLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        applyColors()
        applyLocalization()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
        applyColors()
        applyLocalization()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            playerImageView.layer.borderColor = UIColor(named: "Border")?.cgColor
        }
    }

    // MARK: - Layout

    private func setupLayout() {
        [playerImageView, playerNameLabel, leagueNameLabel,
         countryTitleLabel, countryLabel, birthdateTitleLabel, birthdateLabel]
            .forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([
            playerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            playerImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playerImageView.widthAnchor.constraint(equalToConstant: 80),
            playerImageView.heightAnchor.constraint(equalToConstant: 80),

            playerNameLabel.leadingAnchor.constraint(equalTo: playerImageView.trailingAnchor, constant: 16),
            playerNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            playerNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),

            leagueNameLabel.leadingAnchor.constraint(equalTo: playerNameLabel.leadingAnchor),
            leagueNameLabel.trailingAnchor.constraint(equalTo: playerNameLabel.trailingAnchor),
            leagueNameLabel.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor, constant: 4),

            countryTitleLabel.leadingAnchor.constraint(equalTo: playerNameLabel.leadingAnchor),
            countryTitleLabel.topAnchor.constraint(equalTo: leagueNameLabel.bottomAnchor, constant: 6),
            countryTitleLabel.widthAnchor.constraint(equalToConstant: 64),

            countryLabel.leadingAnchor.constraint(equalTo: countryTitleLabel.trailingAnchor, constant: 4),
            countryLabel.trailingAnchor.constraint(equalTo: playerNameLabel.trailingAnchor),
            countryLabel.centerYAnchor.constraint(equalTo: countryTitleLabel.centerYAnchor),

            birthdateTitleLabel.leadingAnchor.constraint(equalTo: playerNameLabel.leadingAnchor),
            birthdateTitleLabel.topAnchor.constraint(equalTo: countryTitleLabel.bottomAnchor, constant: 4),
            birthdateTitleLabel.widthAnchor.constraint(equalToConstant: 64),
            birthdateTitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20),

            birthdateLabel.leadingAnchor.constraint(equalTo: birthdateTitleLabel.trailingAnchor, constant: 4),
            birthdateLabel.trailingAnchor.constraint(equalTo: playerNameLabel.trailingAnchor),
            birthdateLabel.centerYAnchor.constraint(equalTo: birthdateTitleLabel.centerYAnchor),
        ])
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
