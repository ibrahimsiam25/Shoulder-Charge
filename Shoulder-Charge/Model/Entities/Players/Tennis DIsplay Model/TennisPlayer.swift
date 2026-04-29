//
//  TennisPlayer.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 29/04/2026.
//


struct TennisPlayer: Decodable, ParticipantMappable {
    let playerKey: Int?
    let playerName: String?
    let playerLogo: String?
    let playerCountry: String?

    enum CodingKeys: String, CodingKey {
        case playerKey  = "player_key"
        case playerName = "player_name"
        case playerLogo = "player_logo"
        case playerCountry = "player_country"
    }

    var participantKey: Int?           { playerKey }
    var participantName: String?          { playerName }
    var participantLogoURLString: String? { playerLogo }
    var participantSubtitle: String?      { playerCountry }
}
