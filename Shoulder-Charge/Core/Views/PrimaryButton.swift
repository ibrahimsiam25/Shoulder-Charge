//
//  PrimaryButton.swift
//  Shoulder-Charge
//
//  Created by siam on 30/04/2026.
//

import UIKit

class PrimaryButton: UIButton {

   
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

       required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    private func commonInit() {
            backgroundColor = UIColor(named: "Primary")
            setTitleColor(UIColor(named: "Text Primary"), for: .normal)
            layer.cornerRadius = 12
            layer.masksToBounds = true
    }


 
    func configure(title: String) {
            setTitle(title, for: .normal)

    }
}
