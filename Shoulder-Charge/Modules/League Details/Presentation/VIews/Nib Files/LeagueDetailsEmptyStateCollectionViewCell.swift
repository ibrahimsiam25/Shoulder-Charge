//
//  LeagueDetailsEmptyStateCollectionViewCell.swift
//  Shoulder-Charge
//
//  Created by Codex on 05/05/2026.
//

import UIKit

class LeagueDetailsEmptyStateCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    private let gradientLayer = CAGradientLayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = cardView.bounds
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            applyGradientColors()
            applyTheme()
        }
    }

    func configure(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }

    private func setupStyle() {
        contentView.backgroundColor = .clear
        setupGradient()
        cardView.layer.cornerRadius = 16
        cardView.layer.borderWidth = 1
        cardView.clipsToBounds = true

        iconImageView.image = UIImage(systemName: "calendar.badge.exclamationmark")
        iconImageView.contentMode = .scaleAspectFit

        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontForContentSizeCategory = true

        subtitleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.adjustsFontForContentSizeCategory = true

        applyTheme()
    }

    private func applyTheme() {
        cardView.layer.borderColor = UIColor(named: "Border")?.cgColor
        iconImageView.tintColor = UIColor(named: "Primary")
        titleLabel.textColor = UIColor(named: "Text Primary")
        subtitleLabel.textColor = UIColor(named: "Text Sec")
    }
    
    private func setupGradient() {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = cardView.bounds
        cardView.layer.insertSublayer(gradientLayer, at: 0)
        applyGradientColors()
    }

    private func applyGradientColors() {
        let isDark = traitCollection.userInterfaceStyle == .dark
        gradientLayer.colors = [
            (isDark ? UIColor(hex: "#18181B") : UIColor(hex: "#F4F4F5")).cgColor,
            (isDark ? UIColor(hex: "#000000") : UIColor(hex: "#D4D4D8")).cgColor
        ]
    }
}
