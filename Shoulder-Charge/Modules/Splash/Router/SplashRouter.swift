//
//  SplashRouter.swift
//  Shoulder-Charge
//
//  Created by antigravity on 03/05/2026.
//

import UIKit

class SplashRouter: SplashRouterProtocol {
    
    func navigateToMainApp(from view: SplashViewProtocol) {
        if let vc = view as? UIViewController, let window = vc.view.window {
            HomeRouter.setRoot(on: window)
        }
    }
    
    func navigateToOnboarding(from view: SplashViewProtocol) {
        let onboardingVC = OnboardingRouter.build()
        if let vc = view as? UIViewController {
            vc.navigationController?.setViewControllers([onboardingVC], animated: true)
        }
    }
}
