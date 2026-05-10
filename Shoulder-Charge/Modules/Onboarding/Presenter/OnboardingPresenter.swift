//
//  OnboardingPresenter.swift
//  Shoulder-Charge
//
//  Created by siam on 03/05/2026.
//

import Foundation



class OnboardingPresenter: OnboardingPresenterProtocol {
    
    weak var view: OnboardingViewProtocol? 
    private let router: OnboardingRouterProtocol
    
    private var data: [OnboardingSlide] {
        return LocalizationManager.shared.currentLanguage == "ar" ? Constants.onboardingSlide.reversed() : Constants.onboardingSlide
    }
    
    var slidesCount: Int {
        return data.count
    }
    
    init(view: OnboardingViewProtocol, router: OnboardingRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func getSlide(at index: Int) -> OnboardingSlide {
        return data[index]
    }
    
    func viewDidLoad() {
    }
    
    func didTapContinue(from index: Int) {
        let nextIndex = index + 1
        if nextIndex < data.count {
            view?.goToPage(index: nextIndex)
        } else {
            finishOnboarding()
        }
    }
    
    func didTapSkip() {
        finishOnboarding()
    }
    
    private func finishOnboarding() {
        UserDefaults.standard.set(true, forKey: Constants.userDefaultsIsFirstTimeUserKey)
        if let view = view {
            router.navigateToMainApp(from: view)
        }
    }
}
