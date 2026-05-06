//
//  HomeCollectionCell.swift
//  Shoulder-Charge
//
//  Created by siam on 01/05/2026.
//

import UIKit

class HomeCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(
            roundedRect: contentView.bounds,
            cornerRadius: contentView.layer.cornerRadius
        ).cgPath
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            contentView.layer.borderColor = UIColor(named: "Border")?.cgColor
            layer.shadowColor = UIColor(named: "Border")?.cgColor
        }
    }

    private func setupStyle() {
        backgroundColor = .clear
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor(named: "Border")?.cgColor

        layer.shadowColor = UIColor(named: "Border")?.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.masksToBounds = false

        titleLbl.textColor = .white
    }

    func configure(image: UIImage?, title: String) {
        imageV.image = image
        titleLbl.text = title
    }
}
