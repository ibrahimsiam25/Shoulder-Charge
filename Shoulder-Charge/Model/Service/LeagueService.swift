//
//  LeagueService.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 29/04/2026.
//

import Alamofire


class LeagueService {

    static let shared = LeagueService()
    private init() {}

    func fetchLeagues(
        sport: SportType,
        completion: @escaping (Result<[UnifiedLeagueModel], Error>) -> Void
    ) {
        let endpoint = "\(Constants.baseUrl)\(sport.apiPath)/"
        let parameters: Parameters = [
            "met": Constants.leagues,
            "APIkey": Constants.apiKey
        ]

        switch sport {
        case .football:
            fetch(FootballLeague.self, endpoint: endpoint, parameters: parameters, completion: completion)
        case .basketball:
            fetch(BasketballLeague.self, endpoint: endpoint, parameters: parameters, completion: completion)
        case .cricket:
            fetch(CricketLeague.self, endpoint: endpoint, parameters: parameters, completion: completion)
        case .tennis:
            fetch(TennisLeague.self, endpoint: endpoint, parameters: parameters, completion: completion)
        }
    }

    private func fetch<T: Decodable & LeagueMappable>(
        _ type: T.Type,
        endpoint: String,
        parameters: Parameters,
        completion: @escaping (Result<[UnifiedLeagueModel], Error>) -> Void
    ) {
        AlamofireHelper.shared.request(
            endpoint: endpoint,
            parameters: parameters
        ) { (result: Result<APIResponse<[T]>, Error>) in
            switch result {
            case .success(let response):
                let displayModels = response.result.map { $0.toDisplayModel() }
                completion(.success(displayModels))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
