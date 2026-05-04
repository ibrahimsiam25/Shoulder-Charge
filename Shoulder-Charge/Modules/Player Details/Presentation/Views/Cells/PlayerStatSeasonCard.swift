//
//  PlayerStatSeasonCard.swift
//  Shoulder-Charge
//

import UIKit

class PlayerStatSeasonCard: UICollectionViewCell {

    // MARK: - Views

    private let cardView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 12
        v.layer.borderWidth  = 1
        v.layer.masksToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let seasonLabel      = PlayerStatSeasonCard.makeTitleLabel(size: 20, weight: .bold)
    private let typeChipLabel    = PlayerStatSeasonCard.makeChipLabel()
    private let rankTitleLabel   = PlayerStatSeasonCard.makeSubtitleLabel()
    private let rankValueLabel   = PlayerStatSeasonCard.makeValueLabel()
    private let titlesTitleLabel = PlayerStatSeasonCard.makeSubtitleLabel()
    private let titlesValueLabel = PlayerStatSeasonCard.makeValueLabel()
    private let wonTitleLabel    = PlayerStatSeasonCard.makeSubtitleLabel()
    private let wonValueLabel    = PlayerStatSeasonCard.makeValueLabel()
    private let lostTitleLabel   = PlayerStatSeasonCard.makeSubtitleLabel()
    private let lostValueLabel   = PlayerStatSeasonCard.makeValueLabel()

    private let hardTitleLabel  = PlayerStatSeasonCard.makeSurfaceTitle()
    private let hardWonLabel    = PlayerStatSeasonCard.makeValueLabel()
    private let hardLostLabel   = PlayerStatSeasonCard.makeValueLabel()
    private let clayTitleLabel  = PlayerStatSeasonCard.makeSurfaceTitle()
    private let clayWonLabel    = PlayerStatSeasonCard.makeValueLabel()
    private let clayLostLabel   = PlayerStatSeasonCard.makeValueLabel()
    private let grassTitleLabel = PlayerStatSeasonCard.makeSurfaceTitle()
    private let grassWonLabel   = PlayerStatSeasonCard.makeValueLabel()
    private let grassLostLabel  = PlayerStatSeasonCard.makeValueLabel()

    // MARK: - Factory helpers

    private static func makeTitleLabel(size: CGFloat, weight: UIFont.Weight) -> UILabel {
        let l = UILabel(); l.font = .systemFont(ofSize: size, weight: weight)
        l.translatesAutoresizingMaskIntoConstraints = false; return l
    }
    private static func makeSubtitleLabel() -> UILabel {
        let l = UILabel(); l.font = .systemFont(ofSize: 11)
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false; return l
    }
    private static func makeValueLabel() -> UILabel {
        let l = UILabel(); l.font = .systemFont(ofSize: 13, weight: .semibold)
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false; return l
    }
    private static func makeSurfaceTitle() -> UILabel {
        let l = UILabel(); l.font = .systemFont(ofSize: 11)
        l.translatesAutoresizingMaskIntoConstraints = false; return l
    }
    private static func makeChipLabel() -> UILabel {
        let l = UILabel()
        l.font = .systemFont(ofSize: 11, weight: .semibold)
        l.textAlignment = .center
        l.layer.cornerRadius = 8
        l.layer.masksToBounds = true
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }

    // MARK: - Stacks (for the grid and surface rows)

    private lazy var topRow: UIStackView = {
        let s = UIStackView(arrangedSubviews: [seasonLabel, typeChipLabel])
        s.axis = .horizontal; s.spacing = 8; s.alignment = .center
        s.translatesAutoresizingMaskIntoConstraints = false; return s
    }()

    private lazy var statsRow: UIStackView = {
        let rank   = makeStatStack(title: rankTitleLabel,   value: rankValueLabel)
        let titles = makeStatStack(title: titlesTitleLabel, value: titlesValueLabel)
        let won    = makeStatStack(title: wonTitleLabel,    value: wonValueLabel)
        let lost   = makeStatStack(title: lostTitleLabel,   value: lostValueLabel)
        let s = UIStackView(arrangedSubviews: [rank, titles, won, lost])
        s.axis = .horizontal; s.distribution = .fillEqually; s.spacing = 4
        s.translatesAutoresizingMaskIntoConstraints = false; return s
    }()

    private lazy var surfaceStack: UIStackView = {
        let hard  = makeSurfaceRow(title: hardTitleLabel,  won: hardWonLabel,  lost: hardLostLabel)
        let clay  = makeSurfaceRow(title: clayTitleLabel,  won: clayWonLabel,  lost: clayLostLabel)
        let grass = makeSurfaceRow(title: grassTitleLabel, won: grassWonLabel, lost: grassLostLabel)
        let s = UIStackView(arrangedSubviews: [hard, clay, grass])
        s.axis = .vertical; s.spacing = 5
        s.translatesAutoresizingMaskIntoConstraints = false; return s
    }()

    private func makeStatStack(title: UILabel, value: UILabel) -> UIStackView {
        let s = UIStackView(arrangedSubviews: [title, value])
        s.axis = .vertical; s.alignment = .center; s.spacing = 2; return s
    }

    private func makeSurfaceRow(title: UILabel, won: UILabel, lost: UILabel) -> UIStackView {
        let s = UIStackView(arrangedSubviews: [title, won, lost])
        s.axis = .horizontal; s.distribution = .fillEqually; s.spacing = 4; return s
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout(); applyColors(); applyLocalization()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout(); applyColors(); applyLocalization()
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
        [topRow, statsRow, surfaceStack].forEach { cardView.addSubview($0) }

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            topRow.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            topRow.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            topRow.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),

            statsRow.topAnchor.constraint(equalTo: topRow.bottomAnchor, constant: 10),
            statsRow.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            statsRow.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),

            surfaceStack.topAnchor.constraint(equalTo: statsRow.bottomAnchor, constant: 10),
            surfaceStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            surfaceStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            surfaceStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -12),
        ])
    }

    private func applyColors() {
        cardView.backgroundColor        = UIColor(named: "Surface")
        cardView.layer.borderColor      = UIColor(named: "Border")?.cgColor
        seasonLabel.textColor           = UIColor(named: "Text Primary")
        typeChipLabel.textColor         = UIColor(named: "Primary")
        typeChipLabel.backgroundColor   = UIColor(named: "Primary")?.withAlphaComponent(0.15)

        [rankTitleLabel, titlesTitleLabel, wonTitleLabel, lostTitleLabel,
         hardTitleLabel, clayTitleLabel, grassTitleLabel].forEach {
            $0.textColor = UIColor(named: "Text Sec")
        }
        [rankValueLabel, titlesValueLabel, wonValueLabel, lostValueLabel,
         hardWonLabel, hardLostLabel, clayWonLabel, clayLostLabel,
         grassWonLabel, grassLostLabel].forEach {
            $0.textColor = UIColor(named: "Text Primary")
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
        seasonLabel.text      = stat.season
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
