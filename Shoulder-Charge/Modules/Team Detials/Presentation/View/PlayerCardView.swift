//
//  PlayerCardView.swift
//  Shoulder-Charge
//
//  Created by siam on 05/05/2026.
//


import UIKit
import SDWebImage

@IBDesignable
class PlayerCardView: UIView {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var playerImageView: UIImageView!
    @IBOutlet private weak var borderImageContainer: UIView!
    @IBOutlet private weak var playerNumberLabel: UILabel!
    @IBOutlet private weak var playerNameLabel: UILabel!
    @IBOutlet private weak var playerPositionLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        let nib = UINib(nibName: "PlayerCardView", bundle: Bundle(for: type(of: self)))
        nib.instantiate(withOwner: self, options: nil)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        setupUI()
    }

    private func setupUI() {
        backgroundColor = .clear
        clipsToBounds = false
        layer.masksToBounds = false
        contentView.backgroundColor = .clear
        contentView.clipsToBounds = false

        borderImageContainer.backgroundColor = .clear
        borderImageContainer.layer.borderWidth = 2
        borderImageContainer.layer.borderColor = UIColor(named: "Primary")?.cgColor
            ?? UIColor(red: 0.2, green: 1.0, blue: 0.2, alpha: 1.0).cgColor
        borderImageContainer.clipsToBounds = false

        borderImageContainer.layer.shadowColor = UIColor(named: "Primary")?.cgColor
            ?? UIColor(red: 0.2, green: 1.0, blue: 0.2, alpha: 1.0).cgColor
        borderImageContainer.layer.shadowRadius = 4
        borderImageContainer.layer.shadowOpacity = 0.35
        borderImageContainer.layer.shadowOffset = .zero

        playerImageView.contentMode = .scaleAspectFit
        playerImageView.clipsToBounds = true
        playerImageView.backgroundColor = UIColor(named: "Surface")
        playerImageView.tintColor = UIColor(named: "Primary")?.withAlphaComponent(0.75) ?? .systemGreen

        playerNumberLabel.font = UIFont.boldSystemFont(ofSize: 9)
        playerNumberLabel.textColor = UIColor(named: "Background") ?? .black
        playerNumberLabel.textAlignment = .center
        playerNumberLabel.backgroundColor = UIColor(named: "Primary")
            ?? UIColor(red: 0.2, green: 1.0, blue: 0.2, alpha: 1.0)
        playerNumberLabel.adjustsFontSizeToFitWidth = true
        playerNumberLabel.minimumScaleFactor = 0.6
        playerNumberLabel.clipsToBounds = true

        playerNameLabel.font = UIFont.boldSystemFont(ofSize: 9)
        playerNameLabel.textColor = UIColor(named: "Text Primary") ?? .white
        playerNameLabel.textAlignment = .center
        playerNameLabel.numberOfLines = 1
        playerNameLabel.adjustsFontSizeToFitWidth = true
        playerNameLabel.minimumScaleFactor = 0.65

        playerPositionLabel.font = UIFont.systemFont(ofSize: 8, weight: .semibold)
        playerPositionLabel.textColor = UIColor(named: "Primary")
            ?? UIColor(red: 0.2, green: 1.0, blue: 0.2, alpha: 1.0)
        playerPositionLabel.textAlignment = .center
        playerPositionLabel.numberOfLines = 1
        playerPositionLabel.adjustsFontSizeToFitWidth = true
        playerPositionLabel.minimumScaleFactor = 0.65
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let minSide = min(borderImageContainer.bounds.width, borderImageContainer.bounds.height)
        borderImageContainer.layer.cornerRadius = minSide / 2
        playerImageView.layer.masksToBounds = true
        playerImageView.layer.cornerRadius = max(0, (minSide - 4) / 2)
        playerNumberLabel.layer.cornerRadius = playerNumberLabel.bounds.height / 2
    }

    func config(
        imageURL: String?,
        playerName: String?,
        playerPosition: String?,
        playerNumber: String?
    ) {
        let url = imageURL.flatMap { URL(string: $0) }
        playerImageView.contentMode = .scaleAspectFit
        playerImageView.sd_setImage(
            with: url,
            placeholderImage: UIImage(named: "player")
        ) { [weak self] image, error, _, _ in
            self?.playerImageView.contentMode = image != nil && error == nil ? .scaleAspectFill : .scaleAspectFit
        }

        if let name = playerName, !name.isEmpty {
            playerNameLabel.text = name.uppercased()
            playerNameLabel.isHidden = false
        } else {
            playerNameLabel.isHidden = true
        }

        if let position = playerPosition, !position.isEmpty {
            playerPositionLabel.text = position.uppercased()
            playerPositionLabel.isHidden = false
        } else {
            playerPositionLabel.isHidden = true
        }

        if let number = playerNumber {
            playerNumberLabel.text = number
            playerNumberLabel.isHidden = false
        } else {
            playerNumberLabel.isHidden = true
        }
    }
}
