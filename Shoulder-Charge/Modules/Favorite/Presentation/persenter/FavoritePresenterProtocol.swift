//
//  FavoritePresenterProtocol.swift
//  Shoulder-Charge
//
//  Created by siam on 04/05/2026.
//

import Foundation

protocol FavoritePresenterProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func getSectionsCount() -> Int
    func getItemsCount(in section: Int) -> Int
    func getItem(section: Int, row: Int) -> UnifiedLeagueModel
    func getSectionTitle(at section: Int) -> String
    func deleteFavorite(section: Int, row: Int)
    func navigateToLeagueDetails(section: Int, row: Int)
    func filterFavorites(by query: String)
}
