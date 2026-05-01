//
//  FinishedEventsCollectionViewCell.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 01/05/2026.
//

import UIKit
import SDWebImage

class FinishedEventsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var homeTeamImageView: UIImageView!
    @IBOutlet weak var awayTeamImageView: UIImageView!
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!

    private let gradientLayer = CAGradientLayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupGradient()
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(named: "Border")?.cgColor
        contentView.clipsToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = contentView.bounds
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            applyGradientColors()
            contentView.layer.borderColor = UIColor(named: "Border")?.cgColor
        }
    }

    func configure(with model: UnifiedEventModel) {
        dateLabel.text = model.date
        homeTeamNameLabel.text = model.homeTeam
        awayTeamNameLabel.text = model.awayTeam
        scoreLabel.text = model.result ?? "- : -"
        homeTeamImageView.sd_setImage(with: model.homeTeamLogo,
                                      placeholderImage: UIImage(systemName: "sportscourt.circle"))
        awayTeamImageView.sd_setImage(with: model.awayTeamLogo,
                                      placeholderImage: UIImage(systemName: "sportscourt.circle"))
    }

    private func setupGradient() {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint   = CGPoint(x: 1, y: 1)
        gradientLayer.frame      = contentView.bounds
        contentView.layer.insertSublayer(gradientLayer, at: 0)
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
