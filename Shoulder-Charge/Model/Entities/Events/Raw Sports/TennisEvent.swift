//
//  TennisEvent.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 29/04/2026.
//


struct TennisEvent: Decodable, EventMappable {
    let eventKey: Int?
    let eventDate: String?
    let eventTime: String?
    let eventHomeTeam: String?
    let eventAwayTeam: String?
    let homeTeamLogo: String?
    let awayTeamLogo: String?
    let eventFinalResult: String?
    let eventStatus: String?
    let leagueName: String?
    let leagueRound: String?
    let leagueSeason: String?

    enum CodingKeys: String, CodingKey {
        case eventKey         = "event_key"
        case eventDate        = "event_date"
        case eventTime        = "event_time"
        case eventHomeTeam    = "event_first_player"
        case eventAwayTeam    = "event_second_player"
        case homeTeamLogo     = "event_first_player_logo"
        case awayTeamLogo     = "event_second_player_logo"
        case eventFinalResult = "event_final_result"
        case eventStatus      = "event_status"
        case leagueName       = "tournament_name"
        case leagueRound      = "event_round"
        case leagueSeason     = "event_season"
    }

    var homeTeamLogoString: String? { homeTeamLogo }
    var awayTeamLogoString: String? { awayTeamLogo }
}
