//
//  LeaguesRouter.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 01/05/2026.
//

import UIKit

class LeaguesRouter : LeaguesRouterProtocol{
    static func createModule() -> UIViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "LeaguesViewController") as! LeaguesViewController
        let leagueService = LeagueService.shared
        let router = LeaguesRouter()
        let presenter = LeaguesPresenter(leagueService: leagueService, view: view, router: router)
        view.leaguesPresenter = presenter
        return view
    }
    
    func navigateToLeagueDetails(with leagueId: Int, from view: LeaguesViewProtocol) -> Void {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //Navigate to Details
    }
}
