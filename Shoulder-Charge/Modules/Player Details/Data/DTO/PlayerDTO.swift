//
//  PlayerDTO.swift
//  Shoulder-Charge
//

import Foundation

struct PlayerDTO: Decodable {
    let playerKey: Int?
    let playerName: String?
    let playerCountry: String?
    let playerBday: String?
    let playerLogo: String?
    let stats: [PlayerStatDTO]?
    let tournaments: [PlayerTournamentDTO]?

    enum CodingKeys: String, CodingKey {
        case playerKey    = "player_key"
        case playerName   = "player_name"
        case playerCountry = "player_country"
        case playerBday   = "player_bday"
        case playerLogo   = "player_logo"
        case stats        = "stats"
        case tournaments  = "tournaments"
    }

    func toDomain() -> TennisPlayerModel {
        TennisPlayerModel(
            playerKey: playerKey ?? 0,
            playerName: playerName ?? "",
            playerCountry: playerCountry ?? "",
            playerBday: playerBday ?? "",
            playerLogoURL: playerLogo.flatMap { URL(string: $0) },
            stats: stats?.map { $0.toDomain() } ?? [],
            tournaments: tournaments?.map { $0.toDomain() } ?? []
        )
    }
}

struct PlayerStatDTO: Decodable {
    let season: String?
    let type: String?
    let rank: String?
    let titles: String?
    let matchesWon: String?
    let matchesLost: String?
    let hardWon: String?
    let hardLost: String?
    let clayWon: String?
    let clayLost: String?
    let grassWon: String?
    let grassLost: String?

    enum CodingKeys: String, CodingKey {
        case season       = "season"
        case type         = "type"
        case rank         = "rank"
        case titles       = "titles"
        case matchesWon   = "matches_won"
        case matchesLost  = "matches_lost"
        case hardWon      = "hard_won"
        case hardLost     = "hard_lost"
        case clayWon      = "clay_won"
        case clayLost     = "clay_lost"
        case grassWon     = "grass_won"
        case grassLost    = "grass_lost"
    }

    func toDomain() -> PlayerStat {
        PlayerStat(
            season: season ?? "",
            type: type ?? "",
            rank: rank ?? "",
            titles: titles ?? "",
            matchesWon: matchesWon ?? "",
            matchesLost: matchesLost ?? "",
            hardWon: hardWon ?? "",
            hardLost: hardLost ?? "",
            clayWon: clayWon ?? "",
            clayLost: clayLost ?? "",
            grassWon: grassWon ?? "",
            grassLost: grassLost ?? ""
        )
    }
}

struct PlayerTournamentDTO: Decodable {
    let name: String?
    let season: String?
    let type: String?
    let surface: String?
    let prize: String?

    enum CodingKeys: String, CodingKey {
        case name    = "name"
        case season  = "season"
        case type    = "type"
        case surface = "surface"
        case prize   = "prize"
    }

    func toDomain() -> PlayerTournament {
        PlayerTournament(
            name: name ?? "",
            season: season ?? "",
            type: type ?? "",
            surface: surface ?? "",
            prize: prize ?? ""
        )
    }
}
