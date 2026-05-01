//
//  LeaguesRepositoryProtocol.swift
//  Shoulder-Charge
//

protocol LeaguesRepositoryProtocol {
    func getLeagues(sport: SportType) async throws -> [UnifiedLeagueModel]
}
