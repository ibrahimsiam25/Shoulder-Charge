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
    
    override func setUp() {
        networkClient = NetworkClient.shared
     }

     override func tearDown() {
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

    func testRequestCricketLeaguesSuccess() async throws {
        // Given
        let params = LeagueQueryParams(met: Constants.leagues)
        let url = "\(Constants.baseUrl)cricket/"

        // When
        let response: EventsResponse<[CricketLeagueDTO]> = try await networkClient.request(
            url: url,
            queryParams: params
        )

        // Then
        XCTAssertNotNil(response.result)
        XCTAssertEqual(response.success, 1)
    }

    func testRequestBasketballTeamsSuccess() async throws {
        // Given
        let params = LeagueDetailsQueryParams(met: Constants.teams, leagueId: "757")
        let url = "\(Constants.baseUrl)basketball/"

        // When
        let response: EventsResponse<[BasketballTeamDTO]> = try await networkClient.request(
            url: url,
            queryParams: params
        )

        // Then
        XCTAssertNotNil(response.result)
        XCTAssertEqual(response.success, 1)
    }

    func testRequestFootballFixturesSuccess() async throws {
        // Given
        let params = LeagueDetailsQueryParams(met: Constants.fixtures, leagueId: "205", from: "2023-01-01", to: "2023-12-31")
        let url = "\(Constants.baseUrl)football/"

        // When
        let response: EventsResponse<[FootballEventDTO]> = try await networkClient.request(
            url: url,
            queryParams: params
        )

        // Then
        XCTAssertNotNil(response.result)
        XCTAssertEqual(response.success, 1)
    }

    func testRequestNetworkFailure() async {
        // Given
        let params = LeagueQueryParams(met: Constants.leagues)
        let url = "https://www.dadasdasda.com"

        // When
        do {
            let _: EventsResponse<[FootballLeagueDTO]> = try await networkClient.request(
                url: url,
                queryParams: params
            )
            // Then
            XCTFail("Request was expected to fail with a network error but succeeded")
        } catch {
            // Then
            XCTAssertNotNil(error, "Expected to catch an error, and it was not nil")
        }
    }
}
