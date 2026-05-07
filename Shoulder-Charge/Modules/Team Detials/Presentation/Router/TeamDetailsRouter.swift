//
//  TeamDetailsRouter.swift
//  Shoulder-Charge
//
//  Created by siam on 05/05/2026.
//

import UIKit

class TeamDetailsRouter: TeamDetailsRouterProtocol {
    
    static func build(sport: SportType, teamId: String, leagueId: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(
            withIdentifier: "TeamDetilasViewController"
        ) as! TeamDetilasViewController
        print(leagueId)
        print(teamId)
        let repository = TeamDetailsRepository()
        let router = TeamDetailsRouter()
        let presenter = TeamDetailsPresenter(
            repository: repository,
            view: view,
            router: router,
            sport: sport,
            teamId: teamId,
            leagueId: leagueId
        )
        view.presenter = presenter
        return view
    }
    
}
