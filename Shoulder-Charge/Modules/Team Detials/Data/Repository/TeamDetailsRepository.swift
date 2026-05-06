//
//  TeamDetailsRepository.swift
//  Shoulder-Charge
//
//  Created by siam on 05/05/2026.
//

class TeamDetailsRepository: TeamDetailsRepositoryProtocol {

    private let dataSource: TeamDetailsAPIDataSource

    init(dataSource: TeamDetailsAPIDataSource = TeamDetailsAPIDataSource()) {
        self.dataSource = dataSource
    }

    func getTeamDetails(sport: SportType, leagueId: String, teamId: String) async throws -> TeamModel {
        try await dataSource.fetchTeamDetails(sport: sport, leagueId: leagueId, teamId: teamId)
    }
}
