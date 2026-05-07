//
//  LeagueDetailsRouter.swift
//  Shoulder-Charge
//

import UIKit
protocol LeagueDetailsRouterProtocol {
    static func build(leagueId: String, sport: SportType, leagueName: String, leagueLogo: URL?) -> UIViewController
    func navigateToParticipantDetails( participantId: String, leagueId: String, leagueName: String, sport: SportType, from view: LeagueDetailsViewProtocol)
    
}

class LeagueDetailsRouter: LeagueDetailsRouterProtocol {
    
    static func build(leagueId: String, sport: SportType, leagueName: String, leagueLogo: URL?) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(
            withIdentifier: "LeagueDetailsCollectionViewController"
        ) as! LeagueDetailsCollectionViewController
        let favoriteManager = FavoriteManager.shared
        let repository = LeagueDetailsRepository()
        let router = LeagueDetailsRouter()
        let presenter  = LeagueDetailsPresenter(
            repository: repository,
            view: view,
            router: router,
            leagueId: leagueId,
            sport: sport,
            leagueName: leagueName,
            leagueLogo: leagueLogo,
            favoriteManager: favoriteManager
        )
        view.presenter = presenter
        return view
    }
    
    func navigateToParticipantDetails( participantId: String, leagueId: String, leagueName: String, sport: SportType, from view: LeagueDetailsViewProtocol) {
        guard NetworkMonitor.shared.isConnected else {
            if let vc = view as? UIViewController {
                vc.showNoInternetAlert()
            }
            return
        }
        switch sport {
        case .tennis:
            let playerVC = PlayerDetailsRouter.build(sport: sport, playerId:  participantId, leagueId: leagueId, leagueName: leagueName)
            if let vc = view as? UIViewController {
                vc.navigationController?.pushViewController(playerVC, animated: true)
                
            }
        case .football:
            let teamVC = TeamDetailsRouter.build(sport: sport, teamId:  participantId, leagueId: leagueId)
            if let vc = view as? UIViewController {
                vc.navigationController?.pushViewController(teamVC, animated: true)
            }
        default:
            return
        }
        
        
        
    }
}
