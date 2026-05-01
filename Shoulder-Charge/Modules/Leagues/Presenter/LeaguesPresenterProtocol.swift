//
//  LeaguesPresenterProtocol.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 01/05/2026.
//

import Foundation
protocol LeaguesPresenterProtocol {
    func viewDidLoad()
    func getItemsCount() -> Int
    func getItem (at index: Int) -> UnifiedLeagueModel
    func navigateToLeagueDetails(at index: Int)
    func filterLeagues(by query: String)
}
