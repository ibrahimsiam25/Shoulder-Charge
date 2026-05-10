//
//  LeaguesAPIDataSourceTests.swift
//  Shoulder-ChargeTests
//

import XCTest
@testable import Shoulder_Charge

final class LeaguesAPIDataSourceTests: XCTestCase {
    var dataSource: LeaguesAPIDataSource!
    var mockClient: FakeNetworkClient!

    override func setUp() {
        super.setUp()
        mockClient = FakeNetworkClient(shouldReturnWithError: false)
        dataSource = LeaguesAPIDataSource(client: mockClient)
    }

    override func tearDown() {
        dataSource = nil
        mockClient = nil
        super.tearDown()
    }

    func testFetchFootballLeaguesSuccess() async throws {
        // Given
        let expectedLeagueName = "Premier League"
        mockClient.mockedJSONString = """
        {
            "success": 1,
            "result": [
                {
                    "league_key": 205,
                    "league_name": "\(expectedLeagueName)",
                    "league_logo": "https://example.com/logo.png",
                    "country_name": "England"
                }
            ]
        }
        """

        // When
        let leagues = try await dataSource.fetchLeagues(sport: .football)

        // Then
        XCTAssertTrue(mockClient.loadWasCalled, "The network client should have been called")
        XCTAssertEqual(leagues.count, 1)
        
        let firstLeague = leagues.first
        XCTAssertEqual(firstLeague?.name, expectedLeagueName)
        XCTAssertEqual(firstLeague?.id, 205)
        XCTAssertEqual(firstLeague?.displaySubTitle, "England")
        XCTAssertEqual(firstLeague?.logoURL?.absoluteString, "https://example.com/logo.png")
    }

    func testFetchBasketballLeaguesSuccess() async throws {
        // Given
        let expectedLeagueName = "NBA"
        mockClient.mockedJSONString = """
        {
            "success": 1,
            "result": [
                {
                    "league_key": 756,
                    "league_name": "\(expectedLeagueName)",
                    "country_name": "USA"
                }
            ]
        }
        """

        // When
        let leagues = try await dataSource.fetchLeagues(sport: .basketball)

        // Then
        XCTAssertTrue(mockClient.loadWasCalled)
        XCTAssertEqual(leagues.count, 1)
        XCTAssertEqual(leagues.first?.name, expectedLeagueName)
        XCTAssertEqual(leagues.first?.id, 756)
    }

    func testFetchCricketLeaguesSuccess() async throws {
        // Given
        let expectedLeagueName = "IPL"
        mockClient.mockedJSONString = """
        {
            "success": 1,
            "result": [
                {
                    "league_key": 4,
                    "league_name": "\(expectedLeagueName)",
                    "league_year": "2024"
                }
            ]
        }
        """

        // When
        let leagues = try await dataSource.fetchLeagues(sport: .cricket)

        // Then
        XCTAssertTrue(mockClient.loadWasCalled)
        XCTAssertEqual(leagues.count, 1)
        XCTAssertEqual(leagues.first?.name, expectedLeagueName)
        XCTAssertEqual(leagues.first?.displaySubTitle, "2024")
    }

    func testFetchTennisLeaguesSuccess() async throws {
        // Given
        let expectedLeagueName = "Wimbledon"
        mockClient.mockedJSONString = """
        {
            "success": 1,
            "result": [
                {
                    "league_key": 100,
                    "league_name": "\(expectedLeagueName)",
                    "country_name": "UK",
                    "league_surface": "Grass"
                }
            ]
        }
        """

        // When
        let leagues = try await dataSource.fetchLeagues(sport: .tennis)

        // Then
        XCTAssertTrue(mockClient.loadWasCalled)
        XCTAssertEqual(leagues.count, 1)
        XCTAssertEqual(leagues.first?.name, expectedLeagueName)
    }

    func testFetchLeaguesFailure() async {
        // Given
        mockClient.shouldReturnWithError = true

        // When
        do {
            try await dataSource.fetchLeagues(sport: .football)
            XCTFail("Expected to throw an error")
        } catch {
            // Then
            XCTAssertTrue(mockClient.loadWasCalled)
            XCTAssertNotNil(error)
        }
    }
}
