//
//  FavoritePresenter.swift
//  Shoulder-Charge
//

import Foundation

class FavoritePresenter: FavoritePresenterProtocol {
    
    private weak var view: FavoriteViewProtocol?
    private let router: FavoriteRouterProtocol
    private let favoriteManager: FavoriteManagerProtocol
    private var favoriteLeagues: [UnifiedLeagueModel] = []
    
    init(view: FavoriteViewProtocol, router: FavoriteRouterProtocol, favoriteManager: FavoriteManagerProtocol = FavoriteManager.shared) {
        self.view = view
        self.router = router
        self.favoriteManager = favoriteManager
    }
    
    func viewDidLoad() {
        loadFavorites()
    }
    
    func viewWillAppear() {
        loadFavorites()
    }
    
    private func loadFavorites() {
        favoriteLeagues = favoriteManager.fetchAll()
        view?.reloadTableData()
        view?.toggleEmptyState(visible: favoriteLeagues.isEmpty)
    }
    
    func getItemsCount() -> Int {
        return favoriteLeagues.count
    }
    
    func getItem(at index: Int) -> UnifiedLeagueModel {
        return favoriteLeagues[index]
    }
    
    func deleteFavorite(at index: Int) {
        let league = favoriteLeagues[index]
        favoriteManager.delete(id: league.id)
        favoriteLeagues.remove(at: index)
        view?.toggleEmptyState(visible: favoriteLeagues.isEmpty)
    }
    
    func navigateToLeagueDetails(at index: Int) {
        let league = favoriteLeagues[index]
        router.navigateToLeagueDetails(with: league, from: view)
    }
}
