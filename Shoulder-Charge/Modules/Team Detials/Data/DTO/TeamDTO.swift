//
//  TeamDTO.swift
//  Shoulder-Charge
//
//  Created by siam on 05/05/2026.
//

import Foundation


struct TeamDTO: Decodable {
    let teamKey: Int?
    let teamName: String?
    let teamLogo: String?
    let players: [FootballPlayerDTO]?
    let coaches: [CoachDTO]?
    
    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players
        case coaches
    }
    
    func toDomain() -> TeamModel {
        TeamModel(
            teamKey: teamKey ?? 0,
            teamName: teamName?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
            teamLogoURL: teamLogo.flatMap { URL(string: $0) },
            
            coachName: coaches?.first?.coachName?
                .trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
            
            players: players?.map { $0.toPlayerItem() } ?? []
        )
    }
}

struct FootballPlayerDTO: Decodable {
    let playerKey: Int?
    let playerImage: String?
    let playerName: String?
    let playerNumber: String?
    let playerCountry: String?
    let playerType: String?
    let playerAge: String?
    let playerBirthdate: String?
    let playerInjured: String?
    let playerIsCaptain: String?
    let playerMatchPlayed: String?
    let playerGoals: String?
    let playerYellowCards: String?
    let playerRedCards: String?
    let playerAssists: String?
    let playerRating: String?
    
    enum CodingKeys: String, CodingKey {
        case playerKey = "player_key"
        case playerImage = "player_image"
        case playerName = "player_name"
        case playerNumber = "player_number"
        case playerCountry = "player_country"
        case playerType = "player_type"
        case playerAge = "player_age"
        case playerBirthdate = "player_birthdate"
        case playerInjured = "player_injured"
        case playerIsCaptain = "player_is_captain"
        case playerMatchPlayed = "player_match_played"
        case playerGoals = "player_goals"
        case playerYellowCards = "player_yellow_cards"
        case playerRedCards = "player_red_cards"
        case playerAssists = "player_assists"
        case playerRating = "player_rating"
    }
    
    func toPlayerItem() -> PlayerItem {
        PlayerItem(
            playerKey: playerKey ?? 0,
            name: playerName?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
            imageURL: playerImage.flatMap { URL(string: $0) },
            position: playerType ?? "",
            number:  playerNumber ?? ""
        )
    }
}

struct CoachDTO: Decodable {
    let coachName: String?
    let coachCountry: String?
    let coachAge: String?
    
    enum CodingKeys: String, CodingKey {
        case coachName = "coach_name"
        case coachCountry = "coach_country"
        case coachAge = "coach_age"
    }
}
