//
//  LeagueDetailsRouter.swift
//  Shoulder-Charge
//

import UIKit
protocol LeagueDetailsRouterProtocol {
    static func build(leagueId: String, sport: SportType, leagueName: String, leagueLogo: URL?) -> UIViewController
}

class LeagueDetailsRouter: LeagueDetailsRouterProtocol {

    static func build(leagueId: String, sport: SportType, leagueName: String, leagueLogo: URL?) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(
            withIdentifier: "LeagueDetailsCollectionViewController"
        ) as! LeagueDetailsCollectionViewController
        
        let repository = LeagueDetailsRepository()
        let router = LeagueDetailsRouter()
        let presenter  = LeagueDetailsPresenter(
            repository: repository,
            view: view,
            router: router,
            leagueId: leagueId,
            sport: sport,
            leagueName: leagueName,
            leagueLogo: leagueLogo
        )
        view.presenter = presenter
        return view
    }

}
