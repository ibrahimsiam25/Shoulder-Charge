//
//  PlayerDetailsRepository.swift
//  Shoulder-Charge
//

class PlayerDetailsRepository: PlayerDetailsRepositoryProtocol {

    private let dataSource: PlayerDetailsAPIDataSource

    init(dataSource: PlayerDetailsAPIDataSource = PlayerDetailsAPIDataSource()) {
        self.dataSource = dataSource
    }

    func getPlayerDetails(sport: SportType, leagueId: String, playerId: String) async throws -> TennisPlayerModel {
        try await dataSource.fetchPlayerDetails(sport: sport, leagueId: leagueId, playerId: playerId)
    }
}
