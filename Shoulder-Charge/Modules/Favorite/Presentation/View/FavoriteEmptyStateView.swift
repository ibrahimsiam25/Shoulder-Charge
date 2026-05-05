//
//  FavoriteEmptyStateView.swift
//  Shoulder-Charge
//

import UIKit

class FavoriteEmptyStateView: UIView {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
    }

    private func loadFromNib() {
        guard let view = Bundle.main.loadNibNamed("FavoriteEmptyStateView", owner: self, options: nil)?.first as? UIView else {
            return
        }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }

    func configure() {
        let config = UIImage.SymbolConfiguration(pointSize: 72, weight: .thin)
        iconImageView.image = UIImage(systemName: "star.slash.fill", withConfiguration: config)
        titleLabel.text = L10n.Favorites.emptyTitle
        subtitleLabel.text = L10n.Favorites.emptySubtitle
    }
}
