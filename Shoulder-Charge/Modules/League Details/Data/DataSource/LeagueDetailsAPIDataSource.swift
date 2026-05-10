//
//  LeagueDetailsAPIDataSource.swift
//  Shoulder-Charge
//

import Foundation

class LeagueDetailsAPIDataSource {

    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = NetworkClient.shared) {
        self.client = client
    }

    // MARK: - Public

    func fetchPastEvents(sport: SportType, leagueId: String) async throws -> [UnifiedEventModel] {
        let params = LeagueDetailsQueryParams(
            met: Constants.fixtures,
            leagueId: leagueId,
            from: twoWeeksAgo,
            to: today
        )
        return try await fetchEvents(sport: sport, params: params)
    }

    func fetchUpcomingEvents(sport: SportType, leagueId: String) async throws -> [UnifiedEventModel] {
        let params = LeagueDetailsQueryParams(
            met: Constants.fixtures,
            leagueId: leagueId,
            from: today,
            to: twoWeeksAhead
        )
        return try await fetchEvents(sport: sport, params: params)
    }

    func fetchParticipants(sport: SportType, leagueId: String) async throws -> [LeagueParticipantDisplayModel] {
        let url = "\(Constants.baseUrl)\(sport.apiPath)/"
        let met = sport == .tennis ? Constants.players : Constants.teams
        let params = LeagueDetailsQueryParams(met: met, leagueId: leagueId)

        switch sport {
        case .football:
            let response: EventsResponse<[FootballTeamDTO]> = try await client.request(url: url, queryParams: params)
            return response.result?.map { $0.toParticipantDisplayModel() } ?? []
        case .basketball:
            let response: EventsResponse<[BasketballTeamDTO]> = try await client.request(url: url, queryParams: params)
            return response.result?.map { $0.toParticipantDisplayModel() } ?? []
        case .cricket:
            let response: EventsResponse<[CricketTeamDTO]> = try await client.request(url: url, queryParams: params)
            return response.result?.map { $0.toParticipantDisplayModel() } ?? []
        case .tennis:
            let response: EventsResponse<[TennisPlayerDTO]> = try await client.request(url: url, queryParams: params)
            return response.result?.map { $0.toParticipantDisplayModel() } ?? []
        }
    }

    // MARK: - Private Helpers

    private func fetchEvents(sport: SportType, params: LeagueDetailsQueryParams) async throws -> [UnifiedEventModel] {
        let url = "\(Constants.baseUrl)\(sport.apiPath)/"
        switch sport {
        case .football:
            let response: EventsResponse<[FootballEventDTO]> = try await client.request(url: url, queryParams: params)
            return response.result?.map { $0.toDisplayModel() } ?? []
        case .basketball:
            let response: EventsResponse<[BasketballEventDTO]> = try await client.request(url: url, queryParams: params)
            return response.result?.map { $0.toDisplayModel() } ?? []
        case .cricket:
            let response: EventsResponse<[CricketEventDTO]> = try await client.request(url: url, queryParams: params)
            return response.result?.map { $0.toDisplayModel() } ?? []
        case .tennis:
            let response: EventsResponse<[TennisEventDTO]> = try await client.request(url: url, queryParams: params)
            return response.result?.map { $0.toDisplayModel() } ?? []
        }
    }

    private var twoWeeksAgo: String    { formattedDate(from: Calendar.current.date(byAdding: .month, value: -6, to: Date()) ?? Date()) }
    private var today: String          { formattedDate(from: Date()) }
    private var twoWeeksAhead: String  { formattedDate(from: Calendar.current.date(byAdding: .month, value: 6, to: Date()) ?? Date()) }

    private func formattedDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
