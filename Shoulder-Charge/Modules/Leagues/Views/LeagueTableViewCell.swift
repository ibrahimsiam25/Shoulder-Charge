//
//  LeagueTableViewCell.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 30/04/2026.
//

import UIKit
import SDWebImage

class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueImageView: UIImageView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    private var glowView: UIView?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }

    private func setupStyle() {
        selectionStyle = .none
        backgroundColor = .clear
        accessoryType = .disclosureIndicator

        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(named: "Border")?.cgColor

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 2)
        let glow = UIView()
        glow.translatesAutoresizingMaskIntoConstraints = false
        glow.backgroundColor = UIColor(named: "Primary")?.withAlphaComponent(0.2)
        contentView.insertSubview(glow, belowSubview: leagueImageView)
        NSLayoutConstraint.activate([
            glow.centerXAnchor.constraint(equalTo: leagueImageView.centerXAnchor),
            glow.centerYAnchor.constraint(equalTo: leagueImageView.centerYAnchor),
            glow.widthAnchor.constraint(equalTo: leagueImageView.widthAnchor, multiplier: 1.25),
            glow.heightAnchor.constraint(equalTo: glow.widthAnchor)
        ])
        glowView = glow

        leagueImageView.clipsToBounds = true
        leagueImageView.contentMode = .scaleAspectFit
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 16).cgPath
        leagueImageView.layer.cornerRadius = leagueImageView.frame.width / 2
        glowView?.layer.cornerRadius = (glowView?.frame.width ?? 0) / 2
    }

    func configure(with model: UnifiedLeagueModel) {
        leagueNameLabel.text = model.name
        subtitleLabel.text = model.displaySubTitle
        leagueImageView.sd_setImage(
            with: model.logoURL,
            placeholderImage: UIImage(systemName: "sportscourt.circle")
        )
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            contentView.layer.borderColor = UIColor(named: "Border")?.cgColor
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
