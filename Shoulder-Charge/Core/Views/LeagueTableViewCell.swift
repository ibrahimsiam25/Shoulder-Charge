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

    @IBOutlet weak var starBtn: UIButton!
    
    @IBAction func StarBtnClick(_ sender: UIButton) {
   
         onStarTapped?()
    }
    private let verticalSpacing: CGFloat = 4
    private let horizontalPadding: CGFloat = 8
    private var onStarTapped: (() -> Void)?
    private var isFavorite: Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }

    private func setupStyle() {
        backgroundColor = .clear
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor(named: "Border")?.cgColor

        layer.shadowColor = UIColor(named: "Text Primary")?.cgColor
        layer.shadowOpacity = 0.03
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 2)

        leagueImageView.clipsToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = bounds.inset(by: UIEdgeInsets(
            top: verticalSpacing,
            left: horizontalPadding,
            bottom: verticalSpacing,
            right: horizontalPadding
        ))

        layer.shadowPath = UIBezierPath(roundedRect: contentView.frame, cornerRadius: 16).cgPath

        let radius = leagueImageView.frame.width / 2
        leagueImageView.layer.cornerRadius = radius
        
    }

    func configure(
        with model: UnifiedLeagueModel,
        showsFavorite: Bool,
        isFavorite: Bool,
        onStarTapped: (() -> Void)? = nil
    ) {
        leagueNameLabel.text = model.name
          subtitleLabel.text = model.displaySubTitle
          self.onStarTapped = onStarTapped
          self.isFavorite = isFavorite
          let placeholder = UIImage(named: "LeagueLogo")
              
          leagueImageView.sd_setImage(
              with: model.logoURL,
              placeholderImage: placeholder
          ){ [weak self] _,_,_,_ in
              self?.setNeedsLayout()
              self?.layoutIfNeeded()
          }
        guard starBtn != nil else { return }
         starBtn.isHidden = !showsFavorite

          updateStarUI(isFavorite: isFavorite)
        
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
    private func updateStarUI(isFavorite: Bool) {
        let imageName = isFavorite ? "star.fill" : "star"
        let image = UIImage(systemName: imageName)
        starBtn.setImage(image, for: .normal)
        starBtn.tintColor = UIColor(named: "Primary")
    }
}
