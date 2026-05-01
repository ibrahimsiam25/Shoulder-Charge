//
//  ParticipantDTO.swift
//  Shoulder-Charge
//

struct FootballTeamDTO: Decodable, ParticipantMappable {
    let teamKey: Int?
    let teamName: String?
    let teamLogo: String?
    let countryName: String?

    enum CodingKeys: String, CodingKey {
        case teamKey     = "team_key"
        case teamName    = "team_name"
        case teamLogo    = "team_logo"
        case countryName = "team_country"
    }

    var participantKey: Int?              { teamKey }
    var participantName: String?          { teamName }
    var participantLogoURLString: String? { teamLogo }
    var participantSubtitle: String?      { countryName }
}

struct BasketballTeamDTO: Decodable, ParticipantMappable {
    let teamKey: Int?
    let teamName: String?
    let teamLogo: String?
    let countryName: String?

    enum CodingKeys: String, CodingKey {
        case teamKey     = "team_key"
        case teamName    = "team_name"
        case teamLogo    = "team_logo"
        case countryName = "team_country"
    }

    var participantKey: Int?              { teamKey }
    var participantName: String?          { teamName }
    var participantLogoURLString: String? { teamLogo }
    var participantSubtitle: String?      { countryName }
}

struct CricketTeamDTO: Decodable, ParticipantMappable {
    let teamKey: Int?
    let teamName: String?
    let teamLogo: String?
    let countryName: String?

    enum CodingKeys: String, CodingKey {
        case teamKey     = "team_key"
        case teamName    = "team_name"
        case teamLogo    = "team_logo"
        case countryName = "team_country"
    }

    var participantKey: Int?              { teamKey }
    var participantName: String?          { teamName }
    var participantLogoURLString: String? { teamLogo }
    var participantSubtitle: String?      { countryName }
}

struct TennisPlayerDTO: Decodable, ParticipantMappable {
    let playerKey: Int?
    let playerName: String?
    let playerLogo: String?
    let playerCountry: String?

    enum CodingKeys: String, CodingKey {
        case playerKey     = "player_key"
        case playerName    = "player_name"
        case playerLogo    = "player_logo"
        case playerCountry = "player_country"
    }

    var participantKey: Int?              { playerKey }
    var participantName: String?          { playerName }
    var participantLogoURLString: String? { playerLogo }
    var participantSubtitle: String?      { playerCountry }
}
