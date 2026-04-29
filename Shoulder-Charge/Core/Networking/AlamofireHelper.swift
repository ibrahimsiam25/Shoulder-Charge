//
//  AlamofireHelper.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 29/04/2026.
//


import Alamofire

class AlamofireHelper {
    
    static let shared = AlamofireHelper()
    private init() {}
    
    func request<T: Decodable>(
        endpoint: String,
        parameters: Parameters? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        AF.request(
            endpoint,
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.queryString
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}