//
//  LeagueDetailsService.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 29/04/2026.
//

import Alamofire


class LeagueDetailsService {

    static let shared = LeagueDetailsService()
    private init() {}

    // MARK: - Date Helpers

    private var twoWeeksAgo: String    { formattedDate(from: Date().addingTimeInterval(-14 * 24 * 3600)) }
    private var today: String          { formattedDate(from: Date()) }
    private var twoWeeksAhead: String  { formattedDate(from: Date().addingTimeInterval(14 * 24 * 3600)) }

    private func formattedDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }

    private func baseParams() -> Parameters {
        ["APIkey": Constants.apiKey]
    }

    // MARK: - Past Events

    func fetchPastEvents(
        sport: SportType,
        leagueId: String,
        completion: @escaping (Result<[UnifiedEventModel], Error>) -> Void
    ) {
        let params = baseParams().merging([
            "met": Constants.fixtures,
            "leagueId": leagueId,
            "from": twoWeeksAgo,
            "to": today
        ]) { $1 }

        fetchEvents(sport: sport, parameters: params, completion: completion)
    }

    // MARK: - Upcoming Events

    func fetchUpcomingEvents(
        sport: SportType,
        leagueId: String,
        completion: @escaping (Result<[UnifiedEventModel], Error>) -> Void
    ) {
        let params = baseParams().merging([
            "met": Constants.fixtures,
            "leagueId": leagueId,
            "from": today,
            "to": twoWeeksAhead
        ]) { $1 }

        fetchEvents(sport: sport, parameters: params, completion: completion)
    }


    func fetchTeams(
        sport: SportType,
        leagueId: String,
        completion: @escaping (Result<[UnifiedTeamModel], Error>?) -> Void
    ) {
        guard sport != .tennis else {
            completion(nil)
            return
        }

        let params = baseParams().merging([
            "met": Constants.teams,
            "leagueId": leagueId
        ]) { $1 }

        let endpoint = "\(Constants.baseUrl)\(sport.apiPath)/"

        switch sport {
        case .football:
            fetchTeamModels(FootballTeam.self, endpoint: endpoint, parameters: params, completion: completion)
        case .basketball:
            fetchTeamModels(BasketballTeam.self, endpoint: endpoint, parameters: params, completion: completion)
        case .cricket:
            fetchTeamModels(CricketTeam.self, endpoint: endpoint, parameters: params, completion: completion)
        case .tennis:
            break
        }
    }

    // MARK: - Private Helpers

    private func fetchEvents(
        sport: SportType,
        parameters: Parameters,
        completion: @escaping (Result<[UnifiedEventModel], Error>) -> Void
    ) {
        let endpoint = "\(Constants.baseUrl)\(sport.apiPath)/"

        switch sport {
        case .football:
            fetchEventModels(FootballEvent.self, endpoint: endpoint, parameters: parameters, completion: completion)
        case .basketball:
            fetchEventModels(BasketballEvent.self, endpoint: endpoint, parameters: parameters, completion: completion)
        case .cricket:
            fetchEventModels(CricketEvent.self, endpoint: endpoint, parameters: parameters, completion: completion)
        case .tennis:
            fetchEventModels(TennisEvent.self, endpoint: endpoint, parameters: parameters, completion: completion)
        }
    }

    private func fetchEventModels<T: Decodable & EventMappable>(
        _ type: T.Type,
        endpoint: String,
        parameters: Parameters,
        completion: @escaping (Result<[UnifiedEventModel], Error>) -> Void
    ) {
        AlamofireHelper.shared.request(
            endpoint: endpoint,
            parameters: parameters
        ) { (result: Result<APIResponse<[T]>, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.result.map { $0.toDisplayModel() }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func fetchTeamModels<T: Decodable & TeamMappable>(
        _ type: T.Type,
        endpoint: String,
        parameters: Parameters,
        completion: @escaping (Result<[UnifiedTeamModel], Error>?) -> Void
    ) {
        AlamofireHelper.shared.request(
            endpoint: endpoint,
            parameters: parameters
        ) { (result: Result<APIResponse<[T]>, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.result.map { $0.toDisplayModel() }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
