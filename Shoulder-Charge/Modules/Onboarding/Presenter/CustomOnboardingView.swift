//
//  CustomOnboardingView.swift
//  Shoulder-Charge
//
//  Created by siam on 30/04/2026.
//

import UIKit

class CustomOnboardingView: UIView {

    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var wihteLbl: UILabel!
    
    @IBOutlet weak var primaryLbl: UILabel!
    
    @IBOutlet weak var btn: PrimaryButton!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var LogoLbl: UILabel!

    var onContinueTapped: (() -> Void)?
    var onSkipTapped: (() -> Void)?
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            loadFromNib()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            loadFromNib()
        }
    private func loadFromNib() {
        guard let view = Bundle.main.loadNibNamed("CustomOnboardingView", owner: self, options: nil)?.first as? UIView else {
            return
        }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        wireActions()
    }

    private func wireActions() {
        btn.addTarget(self, action: #selector(handleContinueTap), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(handleSkipTap), for: .touchUpInside)
    }

    @objc private func handleContinueTap() {
        onContinueTapped?()
    }

    @objc private func handleSkipTap() {
        onSkipTapped?()
    }

    func configure(model: OnboardingSlide, totalPages: Int) {
        LogoLbl.text = L10n.Common.appName
        imageV.image = UIImage(named: model.image)
        
        primaryLbl.text = model.titlePrimary
        wihteLbl.text = model.titleWhite
        subTitleLbl.text = model.description
        
        btn.configure(title: L10n.Onboarding.continueTitle)
        skipButton.setTitle(L10n.Onboarding.skip, for: .normal)
    }
}
