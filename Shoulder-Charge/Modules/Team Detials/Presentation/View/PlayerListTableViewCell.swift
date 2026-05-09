//
//  PlayerListTableViewCell.swift
//  Shoulder-Charge
//
//  Created by siam on 05/05/2026.
//

import UIKit
import SDWebImage

class PlayerListTableViewCell: UITableViewCell {

    static let reuseIdentifier = "PlayerListCell"

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imageBorderView: UIView!
    @IBOutlet private weak var playerImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var positionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let minSide = min(imageBorderView.bounds.width, imageBorderView.bounds.height)
        imageBorderView.layer.cornerRadius = minSide / 2
        playerImageView.layer.cornerRadius = max(0, (minSide - 4) / 2)
    }

    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        containerView.backgroundColor = UIColor(named: "Surface")
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowRadius = 4

        imageBorderView.backgroundColor = .clear
        imageBorderView.layer.borderWidth = 2
        imageBorderView.layer.borderColor = UIColor(named: "Primary")?.cgColor
            ?? UIColor(red: 0.2, green: 1.0, blue: 0.2, alpha: 1.0).cgColor
        imageBorderView.layer.shadowColor = UIColor(named: "Primary")?.cgColor
            ?? UIColor(red: 0.2, green: 1.0, blue: 0.2, alpha: 1.0).cgColor
        imageBorderView.layer.shadowRadius = 4
        imageBorderView.layer.shadowOpacity = 0.35
        imageBorderView.layer.shadowOffset = .zero

        playerImageView.contentMode = .scaleAspectFill
        playerImageView.clipsToBounds = true
        playerImageView.backgroundColor = UIColor(named: "Background")
        playerImageView.tintColor = UIColor(named: "Primary")

        nameLabel.textColor = UIColor(named: "Text Primary")
        nameLabel.font = .systemFont(ofSize: 16, weight: .bold)

        positionLabel.textColor = UIColor(named: "Primary")
        positionLabel.font = .systemFont(ofSize: 13, weight: .medium)
    }

    func configure(with viewModel: PlayerRowViewModel) {
        nameLabel.text = viewModel.name
        positionLabel.text = viewModel.position
        playerImageView.sd_setImage(with: viewModel.imageURL, placeholderImage: UIImage(named: "player"))
    }
}
