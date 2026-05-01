//
//  UpComingEventsCollectionViewCell.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 30/04/2026.
//

import UIKit
import SDWebImage

class UpComingEventsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var homeTeamImageView: UIImageView!
    @IBOutlet weak var awayTeamImageView: UIImageView!
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    @IBOutlet weak var vsLabel: UILabel!
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var badgeLabel: UILabel!

    private let gradientLayer = CAGradientLayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupGradient()
        badgeView.backgroundColor = UIColor(named: "Primary")?.withAlphaComponent(0.2)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = contentView.bounds
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            applyGradientColors()
            badgeView.backgroundColor = UIColor(named: "Primary")?.withAlphaComponent(0.2)
        }
    }

    func configure(with model: UnifiedEventModel) {
        dateLabel.text = model.date
        homeTeamNameLabel.text = model.homeTeam
        awayTeamNameLabel.text = model.awayTeam
        badgeLabel.text = model.status
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

extension UIColor {
    convenience init(hex: String) {
        var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hex = hex.hasPrefix("#") ? String(hex.dropFirst()) : hex

        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)

        self.init(
            red:   CGFloat((rgb >> 16) & 0xFF) / 255,
            green: CGFloat((rgb >> 8)  & 0xFF) / 255,
            blue:  CGFloat(rgb         & 0xFF) / 255,
            alpha: 1.0
        )
    }
}
