//
//  LeagueDetailsRouter.swift
//  Shoulder-Charge
//

import UIKit
protocol LeagueDetailsRouterProtocol {
    static func createModule(leagueId: Int, sport: SportType) -> UIViewController
}
class LeagueDetailsRouter {

    static func build(leagueId: String, sport: SportType) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(
            withIdentifier: "LeagueDetailsCollectionViewController"
        ) as! LeagueDetailsCollectionViewController
        
        let repository = LeagueDetailsRepository()
        let router     = LeagueDetailsRouter()
        let presenter  = LeagueDetailsPresenter(
            repository: repository,
            view: view,
            leagueId: leagueId,
            sport: sport
        )
        view.presenter = presenter
        return view
    }

}
