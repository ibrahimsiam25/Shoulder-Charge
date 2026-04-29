//
//  CricketEvent.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 29/04/2026.
//


struct CricketEvent: Decodable, EventMappable {
    let eventKey: String?
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
        case eventDate        = "event_date_start"
        case eventTime        = "event_time"
        case eventHomeTeam    = "event_home_team"
        case eventAwayTeam    = "event_away_team"
        case homeTeamLogo     = "event_home_team_logo"
        case awayTeamLogo     = "event_away_team_logo"
        case eventFinalResult = "event_home_final_result" 
        case eventStatus      = "event_status"
        case leagueName       = "league_name"
        case leagueRound      = "league_round"
        case leagueSeason     = "league_season"
    }

    var homeTeamLogoString: String? { homeTeamLogo }
    var awayTeamLogoString: String? { awayTeamLogo }
}
