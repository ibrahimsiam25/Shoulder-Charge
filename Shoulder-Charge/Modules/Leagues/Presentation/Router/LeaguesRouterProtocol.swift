//
//  LeaguesRouterProtocol.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 01/05/2026.
//

import Foundation

protocol LeaguesRouterProtocol {
    func navigateToLeagueDetails(with leagueId: Int, sport: SportType, leagueName: String, leagueLogo: URL?, from view: LeaguesViewProtocol)
}
