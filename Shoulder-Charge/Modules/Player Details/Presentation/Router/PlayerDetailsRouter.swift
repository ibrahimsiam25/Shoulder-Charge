//
//  PlayerDetailsRouter.swift
//  Shoulder-Charge
//

import UIKit

class PlayerDetailsRouter: PlayerDetailsRouterProtocol {

    static func build(sport: SportType, playerId: String, leagueId: String, leagueName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(
            withIdentifier: "PlayerDetailsViewController"
        ) as! PlayerDetailsViewController

        let repository = PlayerDetailsRepository()
        let router = PlayerDetailsRouter()
        let presenter = PlayerDetailsPresenter(
            repository: repository,
            view: view,
            router: router,
            sport: sport,
            playerId: playerId,
            leagueId: leagueId,
            leagueName: leagueName
        )
        view.presenter = presenter
        return view
    }
}
