//
//  CustomOnboardingView.swift
//  Shoulder-Charge
//
//  Created by siam on 30/04/2026.
//

import UIKit

class CustomOnboardingView: UIView {

    @IBOutlet weak var dotContoller: UIPageControl!
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var wihteLbl: UILabel!
    
    @IBOutlet weak var primaryLbl: UILabel!
    
    @IBOutlet weak var btn: PrimaryButton!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var skipButton: UIButton!

    var onContinueTapped: (() -> Void)?
    var onSkipTapped: (() -> Void)?
    var onPageChanged: ((Int) -> Void)?
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
        dotContoller.addTarget(self, action: #selector(handlePageControlChanged(_:)), for: .valueChanged)
        dotContoller.isUserInteractionEnabled = true
    }

    @objc private func handleContinueTap() {
        onContinueTapped?()
    }

    @objc private func handleSkipTap() {
        onSkipTapped?()
    }

    @objc private func handlePageControlChanged(_ sender: UIPageControl) {
        updatePageIndicators(currentPage: sender.currentPage)
        onPageChanged?(sender.currentPage)
    }

    func configure(model: OnboardingSlide, totalPages: Int) {
        
        imageV.image = UIImage(named: model.image)
        
        primaryLbl.text = model.titlePrimary
        wihteLbl.text = model.titleWhite
        subTitleLbl.text = model.description
        
        btn.configure(title: "Continue")
        
        dotContoller.numberOfPages = totalPages
        let pageIndex = max(0, min(model.currentPage, totalPages - 1))
        dotContoller.currentPage = pageIndex
        updatePageIndicators(currentPage: pageIndex)
    }

    private func updatePageIndicators(currentPage: Int) {
        guard dotContoller.numberOfPages > 0 else { return }
    
            let inactiveColor = dotContoller.pageIndicatorTintColor ?? .lightGray
            let activeColor = dotContoller.currentPageIndicatorTintColor ?? .white
            let inactiveImage = makeDotImage(size: CGSize(width: 8, height: 8), color: inactiveColor)
            let activeImage = makeDotImage(size: CGSize(width: 32, height: 8), color: activeColor)
            for index in 0..<dotContoller.numberOfPages {
                dotContoller.setIndicatorImage(inactiveImage, forPage: index)
            }
            if currentPage < dotContoller.numberOfPages {
                dotContoller.setIndicatorImage(activeImage, forPage: currentPage)
            }
       
    }

    private func makeDotImage(size: CGSize, color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let rect = CGRect(origin: .zero, size: size)
            context.cgContext.setFillColor(color.cgColor)
            let radius = min(size.width, size.height) / 2
            let path = UIBezierPath(roundedRect: rect, cornerRadius: radius)
            path.fill()
        }.withRenderingMode(.alwaysOriginal)
    }
}
