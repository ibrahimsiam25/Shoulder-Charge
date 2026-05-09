//
//  MockingClass.swift
//  Shoulder-ChargeTests
//
//  Created by siam on 09/05/2026.
//

import XCTest
@testable import Shoulder_Charge

final class MockingClass: XCTestCase {
    
    var networkObj = FakeNetworkClient(shouldReturnWithError: false)
    
    func testMockingAPI() async {
        // Given
        let url = " "
        let params = LeagueQueryParams(met: "Leagues")
        
        // When
        do {
            let _: [FootballLeagueDTO] = try await networkObj.request(url: url, queryParams: params)
            
            // Then
            XCTAssertTrue(networkObj.loadWasCalled, "The request function should be called")
        } catch {
            XCTFail("Request failed")
        }
    }
}
