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
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor(named: "Border")?.cgColor
        contentView.clipsToBounds = true

        layer.shadowColor = UIColor(named: "Border")?.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = contentView.bounds
        layer.shadowPath = UIBezierPath(roundedRect: contentView.frame, cornerRadius: 16).cgPath
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            applyGradientColors()
            badgeView.backgroundColor = UIColor(named: "Primary")?.withAlphaComponent(0.2)
            contentView.layer.borderColor = UIColor(named: "Border")?.cgColor
            layer.shadowColor = UIColor(named: "Border")?.cgColor
        }
    }

    func configure(with model: UnifiedEventModel) {
        dateLabel.text = model.date
        homeTeamNameLabel.text = model.homeTeam
        awayTeamNameLabel.text = model.awayTeam
        badgeLabel.text = model.status
        homeTeamImageView.sd_setImage(with: model.homeTeamLogo,
                                      placeholderImage: UIImage(named: "LeagueLogo"))
        awayTeamImageView.sd_setImage(with: model.awayTeamLogo,
                                      placeholderImage: UIImage(named: "sLeagueLogo"))
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
