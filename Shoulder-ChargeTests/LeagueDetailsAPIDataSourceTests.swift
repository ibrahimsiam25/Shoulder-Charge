//
//  LeagueDetailsAPIDataSourceTests.swift
//  Shoulder-ChargeTests
//

import XCTest
@testable import Shoulder_Charge

final class LeagueDetailsAPIDataSourceTests: XCTestCase {
    var dataSource: LeagueDetailsAPIDataSource!
    var mockClient: FakeNetworkClient!

    override func setUp() {
        super.setUp()
        mockClient = FakeNetworkClient(shouldReturnWithError: false)
        dataSource = LeagueDetailsAPIDataSource(client: mockClient)
    }

    override func tearDown() {
        dataSource = nil
        mockClient = nil
        super.tearDown()
    }

    func testFetchPastEventsSuccess() async throws {
        // Given
        mockClient.mockedJSONString = """
        {
            "success": 1,
            "result": [
                {
                    "event_key": 101,
                    "event_date": "2023-10-10",
                    "event_time": "18:00",
                    "event_home_team": "Team A",
                    "event_away_team": "Team B",
                    "home_team_logo": "https://example.com/home.png",
                    "away_team_logo": "https://example.com/away.png",
                    "event_final_result": "2 - 1",
                    "event_status": "Finished",
                    "league_name": "League X"
                }
            ]
        }
        """

        // When
        let events = try await dataSource.fetchPastEvents(sport: .football, leagueId: "205")

        // Then
        XCTAssertTrue(mockClient.loadWasCalled)
        XCTAssertEqual(events.count, 1)
        
        let firstEvent = events.first
        XCTAssertEqual(firstEvent?.eventKey, 101)
        XCTAssertEqual(firstEvent?.homeTeam, "Team A")
        XCTAssertEqual(firstEvent?.awayTeam, "Team B")
        XCTAssertEqual(firstEvent?.result, "2 - 1")
        XCTAssertEqual(firstEvent?.status, "Finished")
    }

    func testFetchUpcomingEventsSuccess() async throws {
        // Given
        mockClient.mockedJSONString = """
        {
            "success": 1,
            "result": [
                {
                    "event_key": 202,
                    "event_date": "2023-12-10",
                    "event_time": "20:00",
                    "event_home_team": "Team C",
                    "event_away_team": "Team D",
                    "event_status": "Upcoming",
                    "league_name": "League Y"
                }
            ]
        }
        """

        // When
        let events = try await dataSource.fetchUpcomingEvents(sport: .basketball, leagueId: "756")

        // Then
        XCTAssertTrue(mockClient.loadWasCalled)
        XCTAssertEqual(events.count, 1)
        
        let firstEvent = events.first
        XCTAssertEqual(firstEvent?.eventKey, 202)
        XCTAssertEqual(firstEvent?.homeTeam, "Team C")
        XCTAssertEqual(firstEvent?.awayTeam, "Team D")
        XCTAssertEqual(firstEvent?.status, "Upcoming")
    }

    func testFetchParticipantsFootballSuccess() async throws {
        // Given
        mockClient.mockedJSONString = """
        {
            "success": 1,
            "result": [
                {
                    "team_key": 303,
                    "team_name": "Arsenal",
                    "team_logo": "https://example.com/arsenal.png",
                    "team_country": "England"
                }
            ]
        }
        """

        // When
        let participants = try await dataSource.fetchParticipants(sport: .football, leagueId: "205")

        // Then
        XCTAssertTrue(mockClient.loadWasCalled)
        XCTAssertEqual(participants.count, 1)
        
        let firstParticipant = participants.first
        XCTAssertEqual(firstParticipant?.key, 303)
        XCTAssertEqual(firstParticipant?.name, "Arsenal")
        XCTAssertEqual(firstParticipant?.subtitle, "England")
    }

    func testFetchParticipantsTennisSuccess() async throws {
        // Given
        mockClient.mockedJSONString = """
        {
            "success": 1,
            "result": [
                {
                    "player_key": 404,
                    "player_name": "Nadal",
                    "player_country": "Spain"
                }
            ]
        }
        """

        // When
        let participants = try await dataSource.fetchParticipants(sport: .tennis, leagueId: "2131")

        // Then
        XCTAssertTrue(mockClient.loadWasCalled)
        XCTAssertEqual(participants.count, 1)
        
        let firstParticipant = participants.first
        XCTAssertEqual(firstParticipant?.key, 404)
        XCTAssertEqual(firstParticipant?.name, "Nadal")
        XCTAssertEqual(firstParticipant?.subtitle, "Spain")
    }

    func testFetchDetailsFailure() async {
        // Given
        mockClient.shouldReturnWithError = true

        // When
        do {
            _ = try await dataSource.fetchPastEvents(sport: .football, leagueId: "205")
            XCTFail("Expected to throw an error")
        } catch {
            // Then
            XCTAssertTrue(mockClient.loadWasCalled)
            XCTAssertNotNil(error)
        }
    }
}
