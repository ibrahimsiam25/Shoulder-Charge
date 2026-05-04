//
//  PlayerDetailsRouterProtocol.swift
//  Shoulder-Charge
//

import UIKit

protocol PlayerDetailsRouterProtocol {
    static func build(sport: SportType, playerId: String, leagueId: String, leagueName: String) -> UIViewController
}
