//
//  FakeNetworkClient.swift
//  Shoulder-Charge
//
//  Created by siam on 09/05/2026.
//

import Foundation
@testable import Shoulder_Charge

class FakeNetworkClient: NetworkClientProtocol {
    var shouldReturnWithError: Bool
    var loadWasCalled = false 
    var mockedJSONString: String = "{}"

    init(shouldReturnWithError: Bool) {
        self.shouldReturnWithError = shouldReturnWithError
    }

    func request<T: Decodable>(url: String, queryParams: LeagueQueryParams) async throws -> T {
        loadWasCalled = true
        
        if shouldReturnWithError {
            throw NSError(domain: "FakeError", code: 0)
        }
      
        let data = mockedJSONString.data(using: .utf8)!
        return try JSONDecoder().decode(T.self, from: data)
    }
}
