//
//  TennisPlayerModel.swift
//  Shoulder-Charge
//

import Foundation

struct TennisPlayerModel {
    let playerKey: Int
    let playerName: String
    let playerCountry: String
    let playerBday: String
    let playerLogoURL: URL?
    let stats: [PlayerStat]
    let tournaments: [PlayerTournament]
}

struct PlayerStat {
    let season: String
    let type: String
    let rank: String
    let titles: String
    let matchesWon: String
    let matchesLost: String
    let hardWon: String
    let hardLost: String
    let clayWon: String
    let clayLost: String
    let grassWon: String
    let grassLost: String
}

struct PlayerTournament {
    let name: String
    let season: String
    let type: String
    let surface: String
    let prize: String
}
