//
//  FavoriteRouter.swift
//  Shoulder-Charge
//

import UIKit

class FavoriteRouter: FavoriteRouterProtocol {
    
 
    func navigateToLeagueDetails(with league: UnifiedLeagueModel, from view: FavoriteViewProtocol?) {
        let detailVC = LeagueDetailsRouter.build(
            leagueId: "\(league.id)",
            sport: league.sport,
            leagueName: league.name,
            leagueLogo: league.logoURL
        )
        
        if let vc = view as? UIViewController {
            vc.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
