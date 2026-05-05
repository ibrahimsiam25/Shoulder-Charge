//
//  TeamModel.swift
//  Shoulder-Charge
//
//  Created by siam on 05/05/2026.
//

import Foundation

struct TeamModel {
    let teamKey: Int
    let teamName: String
    let teamLogoURL: URL?
    let coachName: String
    let players: [PlayerItem]
}

struct PlayerItem {
    let playerKey: Int
    let name: String
    let imageURL: URL?
    let position: String
}
