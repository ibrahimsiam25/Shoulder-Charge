//
//  OnboardingRouter.swift
//  Shoulder-Charge
//
//  Created by siam on 03/05/2026.
//

import UIKit

class OnboardingRouter: OnboardingRouterProtocol {
    
    static func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
        let router = OnboardingRouter()
        let presenter = OnboardingPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func navigateToMainApp(from view: OnboardingViewProtocol) {
        let mainAppVC = HomeRouter.createModule()
        if let vc = view as? UIViewController {
            vc.navigationController?.setViewControllers([mainAppVC], animated: true)
        }
    }
}
