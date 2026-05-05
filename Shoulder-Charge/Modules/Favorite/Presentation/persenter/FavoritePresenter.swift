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
    private var sections: [(sport: SportType, leagues: [UnifiedLeagueModel])] = []
    private var currentQuery: String = ""

    private static let sportOrder: [SportType] = [.football, .basketball, .tennis, .cricket]

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
        applyFilter()
    }

    private func applyFilter() {
        let filtered: [UnifiedLeagueModel]
        if currentQuery.isEmpty {
            filtered = favoriteLeagues
        } else {
            filtered = favoriteLeagues.filter { $0.name.localizedCaseInsensitiveContains(currentQuery) }
        }

        var dict: [SportType: [UnifiedLeagueModel]] = [:]
        for league in filtered {
            dict[league.sport, default: []].append(league)
        }
        sections = Self.sportOrder.compactMap { sport in
            guard let leagues = dict[sport], !leagues.isEmpty else { return nil }
            return (sport: sport, leagues: leagues)
        }

        view?.reloadTableData()
        view?.toggleEmptyState(visible: filtered.isEmpty)
    }

    func filterFavorites(by query: String) {
        currentQuery = query
        applyFilter()
    }

    func getSectionsCount() -> Int {
        return sections.count
    }

    func getItemsCount(in section: Int) -> Int {
        return sections[section].leagues.count
    }

    func getItem(section: Int, row: Int) -> UnifiedLeagueModel {
        return sections[section].leagues[row]
    }

    func getSectionTitle(at section: Int) -> String {
        return sections[section].sport.title
    }

    func deleteFavorite(section: Int, row: Int) {
        let league = sections[section].leagues[row]
        favoriteManager.delete(id: league.id)
        favoriteLeagues.removeAll { $0.id == league.id }
        applyFilter()
    }

    func navigateToLeagueDetails(section: Int, row: Int) {
        let league = sections[section].leagues[row]
        router.navigateToLeagueDetails(with: league, from: view)
    }
}
