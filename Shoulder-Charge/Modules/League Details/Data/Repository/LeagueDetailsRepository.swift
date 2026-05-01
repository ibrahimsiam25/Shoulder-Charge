//
//  LeagueDetailsRepository.swift
//  Shoulder-Charge
//

class LeagueDetailsRepository: LeagueDetailsRepositoryProtocol {

    private let dataSource: LeagueDetailsAPIDataSource

    init(dataSource: LeagueDetailsAPIDataSource = LeagueDetailsAPIDataSource()) {
        self.dataSource = dataSource
    }

    func getPastEvents(sport: SportType, leagueId: String) async throws -> [UnifiedEventModel] {
        try await dataSource.fetchPastEvents(sport: sport, leagueId: leagueId)
    }

    func getUpcomingEvents(sport: SportType, leagueId: String) async throws -> [UnifiedEventModel] {
        try await dataSource.fetchUpcomingEvents(sport: sport, leagueId: leagueId)
    }

    func getParticipants(sport: SportType, leagueId: String) async throws -> [LeagueParticipantDisplayModel] {
        try await dataSource.fetchParticipants(sport: sport, leagueId: leagueId)
    }
}
