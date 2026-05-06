//
//  PlayerDetailsRepositoryProtocol.swift
//  Shoulder-Charge
//
//  Created by siam on 05/05/2026.
//

protocol TeamDetailsRepositoryProtocol {
    func getTeamDetails(sport: SportType, leagueId: String, teamId: String) async throws -> TeamModel
    
}
