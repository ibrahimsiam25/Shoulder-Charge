//
//  UnifiedEventModel.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 29/04/2026.
//

import Foundation

struct UnifiedEventModel {
    let eventKey: String?
    let date: String?
    let time: String?
    let homeTeam: String?
    let awayTeam: String?
    let homeTeamLogo: URL?
    let awayTeamLogo: URL?
    let result: String?
    let status: String?
    let leagueName: String?
    let leagueRound: String?
    let leagueSeason: String?
}

struct UnifiedTeamModel {
    let teamKey: String?
    let teamName: String?
    let teamLogo: URL?
    let countryName: String?
}
