//
//  LeaguesRepository.swift
//  Shoulder-Charge
//

class LeaguesRepository: LeaguesRepositoryProtocol {

    private let dataSource: LeaguesAPIDataSource

    init(dataSource: LeaguesAPIDataSource = LeaguesAPIDataSource()) {
        self.dataSource = dataSource
    }

    func getLeagues(sport: SportType) async throws -> [UnifiedLeagueModel] {
        try await dataSource.fetchLeagues(sport: sport)
    }
}
