//
//  TeamDetailsAPIDataSource.swift
//  Shoulder-Charge
//
//  Created by siam on 05/05/2026.
//

import Foundation

class TeamDetailsAPIDataSource {

    private let client: NetworkClient

    init(client: NetworkClient = .shared) {
        self.client = client
    }

    func fetchTeamDetails(sport: SportType, leagueId: String, teamId: String) async throws -> TeamModel {
        let url = "\(Constants.baseUrl)\(sport.apiPath)/"
        let params = TeamQueryParams(met: Constants.teams, leagueId: leagueId,teamId:teamId)
        let response: EventsResponse<[TeamDTO]> = try await client.request(url: url, queryParams: params)
        guard let team = response.result?.first else {
            throw URLError(.badServerResponse)
        }
        return team.toDomain()
    }
}

