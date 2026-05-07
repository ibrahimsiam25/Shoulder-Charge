//
//  HomeRouter.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 03/05/2026.
//

import UIKit

class HomeRouter: HomeRouterProtocol {
    
    static func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBar = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
        return tabBar
    }
    
    static func setRoot(on window: UIWindow) {
        let tabBar = createModule()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootNav = storyboard.instantiateViewController(withIdentifier: "RootNav") as! UINavigationController
        rootNav.isNavigationBarHidden = true
        rootNav.viewControllers = [tabBar]
        
        UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromLeft) {
            window.rootViewController = rootNav
        }
    }
    
    func navigateToLeagues(with sportType: SportType, from view: HomeViewProtocol) {
        guard NetworkMonitor.shared.isConnected else {
            if let vc = view as? UIViewController {
                vc.showNoInternetAlert()
            }
            return
        }
        let leaguesVC = LeaguesRouter.createModule(sportType: sportType)
        if let vc = view as? UIViewController {
            vc.navigationController?.pushViewController(leaguesVC, animated: true)
        }
    }
}
