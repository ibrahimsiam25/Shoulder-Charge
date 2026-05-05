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
        
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        titleLbl.textColor = .white

    }

    func configure(image: UIImage?, title: String) {
        imageV.image = image
        titleLbl.text = title
    }
}
