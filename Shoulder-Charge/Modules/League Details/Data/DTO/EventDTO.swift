//
//  EventDTO.swift
//  Shoulder-Charge
//

struct FootballEventDTO: Decodable, EventMappable {
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
        case eventHomeTeam    = "event_home_team"
        case eventAwayTeam    = "event_away_team"
        case homeTeamLogo     = "home_team_logo"
        case awayTeamLogo     = "away_team_logo"
        case eventFinalResult = "event_final_result"
        case eventStatus      = "event_status"
        case leagueName       = "league_name"
        case leagueRound      = "league_round"
        case leagueSeason     = "league_season"
    }

    var homeTeamLogoString: String? { homeTeamLogo }
    var awayTeamLogoString: String? { awayTeamLogo }
}

struct BasketballEventDTO: Decodable, EventMappable {
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
        case eventHomeTeam    = "event_home_team"
        case eventAwayTeam    = "event_away_team"
        case homeTeamLogo     = "event_home_team_logo"
        case awayTeamLogo     = "event_away_team_logo"
        case eventFinalResult = "event_final_result"
        case eventStatus      = "event_status"
        case leagueName       = "league_name"
        case leagueRound      = "league_round"
        case leagueSeason     = "league_season"
    }

    var homeTeamLogoString: String? { homeTeamLogo }
    var awayTeamLogoString: String? { awayTeamLogo }
}

struct CricketEventDTO: Decodable, EventMappable {
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

struct TennisEventDTO: Decodable, EventMappable {
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
