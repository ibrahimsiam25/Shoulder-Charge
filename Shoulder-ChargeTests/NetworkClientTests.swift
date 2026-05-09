//
//  NetworkClientTests.swift
//  Shoulder-ChargeTests
//
//  Created by siam on 09/05/2026.
//

import XCTest
@testable import Shoulder_Charge

final class NetworkClientTests: XCTestCase {
    var networkClient: NetworkClient!
    
    override func setUpWithError() throws {
        networkClient = NetworkClient.shared
     }

     override func tearDownWithError() throws {
         networkClient = nil
     }

    func testRequestFootballLeaguesSuccess() async throws {

          // Given
        let params = await LeagueQueryParams(
              met: Constants.leagues
          )

        let url = "\(await Constants.baseUrl)football/"

          // When
          let response: EventsResponse<[FootballLeagueDTO]> =
          try await networkClient.request(
              url: url,
              queryParams: params
          )

          // Then
          XCTAssertNotNil(response.result)

          XCTAssertFalse(response.result?.isEmpty ?? true)

          XCTAssertEqual(response.success, 1)
      }

}
