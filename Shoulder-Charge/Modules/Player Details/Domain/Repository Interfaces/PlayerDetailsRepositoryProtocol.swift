//
//  PlayerDetailsRepositoryProtocol.swift
//  Shoulder-Charge
//

protocol PlayerDetailsRepositoryProtocol {
    func getPlayerDetails(sport: SportType, leagueId: String, playerId: String) async throws -> TennisPlayerModel
}
