//
//  PlayerTournamentCell.swift
//  Shoulder-Charge
//

import UIKit

class PlayerTournamentCell: UICollectionViewCell {

    // MARK: - Views

    private let cardView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 12
        v.layer.borderWidth  = 1
        v.layer.masksToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let nameLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 15, weight: .semibold)
        l.numberOfLines = 1
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let seasonLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 12)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let surfaceChipLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 11, weight: .semibold)
        l.textAlignment = .center
        l.layer.cornerRadius = 8
        l.layer.masksToBounds = true
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let typeChipLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 11, weight: .semibold)
        l.textAlignment = .center
        l.layer.cornerRadius = 8
        l.layer.masksToBounds = true
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let prizeLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var chipStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [surfaceChipLabel, typeChipLabel])
        s.axis = .horizontal; s.spacing = 6; s.alignment = .center
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        applyColors()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
        applyColors()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            cardView.layer.borderColor = UIColor(named: "Border")?.cgColor
        }
    }

    // MARK: - Layout

    private func setupLayout() {
        contentView.addSubview(cardView)
        [nameLabel, seasonLabel, chipStack, prizeLabel].forEach { cardView.addSubview($0) }

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),

            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: prizeLabel.leadingAnchor, constant: -8),

            seasonLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            seasonLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            seasonLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

            chipStack.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor, constant: 6),
            chipStack.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            chipStack.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor, constant: -10),

            prizeLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            prizeLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
        ])
    }

    private func applyColors() {
        cardView.backgroundColor = UIColor(named: "Surface")
        cardView.layer.borderColor = UIColor(named: "Border")?.cgColor
        nameLabel.textColor   = UIColor(named: "Text Primary")
        seasonLabel.textColor = UIColor(named: "Text Sec")
        typeChipLabel.textColor       = UIColor(named: "Primary")
        typeChipLabel.backgroundColor = UIColor(named: "Primary")?.withAlphaComponent(0.15)
        prizeLabel.textColor  = UIColor(named: "Primary")
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
        if s.contains("clay") {
            return (UIColor(red: 0.8, green: 0.3, blue: 0.1, alpha: 1),
                    UIColor(red: 0.8, green: 0.3, blue: 0.1, alpha: 0.15))
        } else if s.contains("grass") {
            return (UIColor(red: 0.1, green: 0.6, blue: 0.2, alpha: 1),
                    UIColor(red: 0.1, green: 0.6, blue: 0.2, alpha: 0.15))
        } else {
            return (UIColor(red: 0.1, green: 0.4, blue: 0.8, alpha: 1),
                    UIColor(red: 0.1, green: 0.4, blue: 0.8, alpha: 0.15))
        }
    }
}
