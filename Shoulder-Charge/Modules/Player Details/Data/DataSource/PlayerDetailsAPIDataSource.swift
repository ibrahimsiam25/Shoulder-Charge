//
//  PlayerDetailsAPIDataSource.swift
//  Shoulder-Charge
//

import Foundation

class PlayerDetailsAPIDataSource {

    private let client: NetworkClient

    init(client: NetworkClient = .shared) {
        self.client = client
    }

    func fetchPlayerDetails(sport: SportType, leagueId: String, playerId: String) async throws -> TennisPlayerModel {
        let url = "\(Constants.baseUrl)\(sport.apiPath)/"
        let params = PlayerQueryParams(met: Constants.players, leagueId: leagueId, playerId: playerId)
        let response: EventsResponse<[PlayerDTO]> = try await client.request(url: url, queryParams: params)
        guard let player = response.result?.first else {
            throw URLError(.badServerResponse)
        }
        return player.toDomain()
    }
}
