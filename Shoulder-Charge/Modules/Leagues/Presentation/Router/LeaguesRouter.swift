//
//  LeaguesRouter.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 01/05/2026.
//

import UIKit

class LeaguesRouter : LeaguesRouterProtocol{
    static func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "LeaguesViewController") as! LeaguesViewController
        let repository = LeaguesRepository()
        let router = LeaguesRouter()
        let presenter = LeaguesPresenter(repository: repository, view: view, router: router)
        view.leaguesPresenter = presenter
        return view
    }
    
    func navigateToLeagueDetails(with leagueId: Int, sport: SportType, from view: LeaguesViewProtocol) {
        let detailVC = LeagueDetailsRouter.createModule(leagueId: leagueId, sport: sport)
        if let vc = view as? UIViewController {
            vc.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
