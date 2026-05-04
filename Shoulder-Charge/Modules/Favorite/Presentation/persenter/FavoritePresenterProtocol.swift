//
//  FavoritePresenterProtocol.swift
//  Shoulder-Charge
//
//  Created by siam on 04/05/2026.
//

protocol FavoritePresenterProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func getItemsCount() -> Int
    func getItem(at index: Int) -> UnifiedLeagueModel
    func deleteFavorite(at index: Int)
    func navigateToLeagueDetails(at index: Int)
}
