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
        participantImageView.layer.cornerRadius = participantImageView.frame.width / 2
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            participantImageView.layer.borderColor = UIColor(named: "Border")?.cgColor
        }
    }

    private func setupStyle() {
        participantImageView.clipsToBounds = true
        participantImageView.contentMode = .scaleAspectFill
        participantImageView.layer.borderWidth = 1.5
        participantImageView.layer.borderColor = UIColor(named: "Border")?.cgColor
    }

    func configure(with model:LeagueParticipantDisplayModel) {
        participantNameLabel.text = model.name
        participantImageView.sd_setImage(
            with: model.logoURL,
            placeholderImage: UIImage(systemName: "person.circle")
        )
    }
}
