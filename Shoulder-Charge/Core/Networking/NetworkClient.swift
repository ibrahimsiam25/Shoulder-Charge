//
//  NetworkClient.swift
//  Shoulder-Charge
//

import Alamofire

class NetworkClient {

    static let shared = NetworkClient()
    private init() {}

    func request<T: Decodable>(url: String, queryParams: LeagueQueryParams) async throws -> T {
        try await AF.request(
            url,
            parameters: queryParams.asDictionary,
            encoding: URLEncoding.queryString
        )
        .validate()
        .serializingDecodable(T.self)
        .value
    }
}
