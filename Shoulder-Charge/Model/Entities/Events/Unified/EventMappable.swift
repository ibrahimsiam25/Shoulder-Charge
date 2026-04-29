//
//  EventMappable.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 29/04/2026.
//

import Foundation

protocol EventMappable {
    var eventKey: String? { get }
    var eventDate: String? { get }
    var eventTime: String? { get }
    var eventHomeTeam: String? { get }
    var eventAwayTeam: String? { get }
    var homeTeamLogoString: String? { get }
    var awayTeamLogoString: String? { get }
    var eventFinalResult: String? { get }
    var eventStatus: String? { get }
    var leagueName: String? { get }
    var leagueRound: String? { get }
    var leagueSeason: String? { get }
}

extension EventMappable {
    func toDisplayModel() -> UnifiedEventModel {
        UnifiedEventModel(
            eventKey: eventKey,
            date: eventDate,
            time: eventTime,
            homeTeam: eventHomeTeam,
            awayTeam: eventAwayTeam,
            homeTeamLogo: homeTeamLogoString.flatMap { URL(string: $0) },
            awayTeamLogo: awayTeamLogoString.flatMap { URL(string: $0) },
            result: eventFinalResult,
            status: eventStatus,
            leagueName: leagueName,
            leagueRound: leagueRound,
            leagueSeason: leagueSeason
        )
    }
}


