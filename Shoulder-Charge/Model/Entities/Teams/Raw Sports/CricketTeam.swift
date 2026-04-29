//
//  CricketTeam.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 29/04/2026.
//


struct CricketTeam: Decodable, ParticipantMappable {
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
    
    var participantKey: Int?           { teamKey }
    var participantName: String?          { teamName }
    var participantLogoURLString: String? { teamLogo }
    var participantSubtitle: String?      { countryName }
}
