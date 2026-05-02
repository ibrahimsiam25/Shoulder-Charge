//
//  LeaguesRouter.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 01/05/2026.
//

import UIKit

class LeaguesRouter : LeaguesRouterProtocol{
    static func createModule(sportType:SportType) -> UIViewController {
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "LeaguesViewController") as! LeaguesViewController
        let repository = LeaguesRepository()
        let router = LeaguesRouter()
        let presenter = LeaguesPresenter(repository: repository, view: view, router: router,  sportType: sportType)
        view.leaguesPresenter = presenter
        return view
    }
    
    func navigateToLeagueDetails(with leagueId: Int, sport: SportType, leagueName: String, leagueLogo: URL?, from view: LeaguesViewProtocol) {
        let detailVC = LeagueDetailsRouter.build(leagueId: "\(leagueId)", sport: sport, leagueName: leagueName, leagueLogo: leagueLogo)
        if let vc = view as? UIViewController {
            vc.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
