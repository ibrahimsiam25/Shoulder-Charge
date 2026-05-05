//
//  LeagueParticipantCollectionViewCell.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 01/05/2026.
//

import UIKit
import SDWebImage

class LeagueParticipantCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var participantImageView: UIImageView!
    @IBOutlet weak var participantNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let radius = participantImageView.frame.width / 2
        participantImageView.layer.cornerRadius = radius
        layer.shadowPath = UIBezierPath(ovalIn: participantImageView.frame).cgPath
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            participantImageView.layer.borderColor = UIColor(named: "Border")?.cgColor
            layer.shadowColor = UIColor(named: "Border")?.cgColor
        }
    }

    private func setupStyle() {
        participantImageView.clipsToBounds = true
        participantImageView.contentMode = .scaleAspectFill
        participantImageView.layer.borderWidth = 1.5
        participantImageView.layer.borderColor = UIColor(named: "Border")?.cgColor

        layer.shadowColor = UIColor(named: "Border")?.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }

    func configure(with model:LeagueParticipantDisplayModel) {
        participantNameLabel.text = model.name
        participantImageView.sd_setImage(
            with: model.logoURL,
            placeholderImage: UIImage(named: "LeagueLogo")
        )
    }
}
