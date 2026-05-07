//
//  TeamDetailsRouterProtocol.swift
//  Shoulder-Charge
//
//  Created by siam on 05/05/2026.
//

import UIKit

protocol TeamDetailsRouterProtocol {
    static func build(sport: SportType, teamId: String, leagueId: String) -> UIViewController
}
