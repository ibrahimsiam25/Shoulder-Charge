//
//  LeaguesAPIDataSource.swift
//  Shoulder-Charge
//

class LeaguesAPIDataSource {

    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = NetworkClient.shared) {
        self.client = client
    }

    func fetchLeagues(sport: SportType) async throws -> [UnifiedLeagueModel] {
        let url = "\(Constants.baseUrl)\(sport.apiPath)/"
        let params = LeagueQueryParams(met: Constants.leagues)

        switch sport {
        case .football:
            let response: EventsResponse<[FootballLeagueDTO]> = try await client.request(url: url, queryParams: params)
            return response.result?.map { $0.toDomain() } ?? []
        case .basketball:
            let response: EventsResponse<[BasketballLeagueDTO]> = try await client.request(url: url, queryParams: params)
            return response.result?.map { $0.toDomain() } ?? []
        case .cricket:
            let response: EventsResponse<[CricketLeagueDTO]> = try await client.request(url: url, queryParams: params)
            return response.result?.map { $0.toDomain() } ?? []
        case .tennis:
            let response: EventsResponse<[TennisLeagueDTO]> = try await client.request(url: url, queryParams: params)
            return response.result?.map { $0.toDomain() } ?? []
        }
    }
}
