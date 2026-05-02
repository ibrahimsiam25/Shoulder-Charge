//
//  LeagueDetailsRouter.swift
//  Shoulder-Charge
//

import UIKit
protocol LeagueDetailsRouterProtocol {
    static func createModule(leagueId: Int, sport: SportType) -> UIViewController
}
class LeagueDetailsRouter {

//    static func createModule(leagueId: Int, sport: SportType) -> UIViewController {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let view = storyboard.instantiateViewController(
//            withIdentifier: "LeagueDetailsViewController"
//        ) as! LeagueDetailsViewController
//        let repository = LeagueDetailsRepository()
//        let presenter = LeagueDetailsPresenter(
//            repository: repository,
//            view: view,
//            leagueId: String(leagueId),
//            sport: sport
//        )
//        view.presenter = presenter
//        return view
//    }
}
