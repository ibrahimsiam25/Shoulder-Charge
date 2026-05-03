//
//  SplashPresenter.swift
//  Shoulder-Charge
//
//  Created by siam on 29/04/2026.
//

import Foundation

protocol SplashPresenterProtocol: AnyObject {
    func startAnimation()
    func handleTransition()
}

final class SplashPresenter: SplashPresenterProtocol {

    weak var view: SplashViewProtocol?
    private let router: SplashRouterProtocol

    init(view: SplashViewProtocol, router: SplashRouterProtocol = SplashRouter()) {
        self.view = view
        self.router = router
    }

    func startAnimation() {
        view?.animateLogoParts()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) { [weak self] in
            self?.view?.showAppTitle()
        }
    }
    
    func handleTransition() {
        let isFirstTime = UserDefaults.standard.bool(forKey: Constants.userDefaultsIsFirstTimeUserKey)
        if let view = view {
            if isFirstTime {
                router.navigateToMainApp(from: view)
            } else {
                router.navigateToOnboarding(from: view)
            }
        }
    }
}
