//
//  NetworkClient.swift
//  Shoulder-Charge
//

import Alamofire

class NetworkClient {

    static let shared = NetworkClient()
    private init() {}

    func request<T: Decodable>(url: String, queryParams: LeagueQueryParams) async throws -> T {
        let task = AF.request(
            url,
            parameters: queryParams.asDictionary,
            encoding: URLEncoding.queryString
        )
        .validate()
        .serializingDecodable(T.self)

        let result = await task.result
        switch result {
        case .success(let value):
            return value
        case .failure(let error):
            print("❌ [NetworkClient] URL: \(url)")
            print("❌ [NetworkClient] Params: \(queryParams.asDictionary)")
            print("❌ [NetworkClient] Error: \(error)")
            throw error
        }
    }
}
