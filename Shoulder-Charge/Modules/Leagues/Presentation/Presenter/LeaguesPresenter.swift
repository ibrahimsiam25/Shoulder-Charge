//
//  LeaguesPresenter.swift
//  Shoulder-Charge
//
import Foundation

@MainActor
class LeaguesPresenter: LeaguesPresenterProtocol {

    private let repository: LeaguesRepositoryProtocol
    private var view: LeaguesViewProtocol!
    var router: LeaguesRouterProtocol!
    private var leagues: [UnifiedLeagueModel] = []
    private var sportType:SportType!
    private var filteredLeagues: [UnifiedLeagueModel] = []
    private let favoriteManager:FavoriteManagerProtocol
    init(repository: LeaguesRepositoryProtocol, view: LeaguesViewProtocol!, router: LeaguesRouterProtocol!,sportType:SportType,
     favoriteManager:FavoriteManagerProtocol
    ) {
        self.repository = repository
        self.view = view
        self.router = router
        self.sportType = sportType
        self.favoriteManager = favoriteManager
    }

    func viewDidLoad() {
        view.toggleLoading(true)
        Task {
            do {
                let result = try await repository.getLeagues(sport:sportType )
                leagues = result
                filteredLeagues = result
                view.toggleLoading(false)
                view.reloadTableData()
            } catch {
                view.toggleLoading(false)
                print("Error fetching leagues: \(error)")
            }
        }
    }

    func getItemsCount() -> Int {
        return filteredLeagues.count
    }

    func getItem(at index: Int) -> UnifiedLeagueModel {
        return filteredLeagues[index]
    }

    func filterLeagues(by query: String) {
        if query.trimmingCharacters(in: .whitespaces).isEmpty {
            filteredLeagues = leagues
        } else {
            filteredLeagues = leagues.filter { $0.name.localizedCaseInsensitiveContains(query) }
        }
        view.reloadTableData()
    }

    func navigateToLeagueDetails(at index: Int) {
        let league = filteredLeagues[index]
        router.navigateToLeagueDetails(with: league.id, sport: league.sport, leagueName: league.name, leagueLogo: league.logoURL, from: view)
    }
    func getSprotType()->SportType{
        return sportType
    }
    func isFavorite(at index: Int) -> Bool {
        let league = filteredLeagues[index]
        return favoriteManager.isExist(id: league.id)
    }

    func toggleFavorite(at index: Int) {
        let league = filteredLeagues[index]
        if favoriteManager.isExist(id: league.id) {
            favoriteManager.delete(id: league.id)
        } else {
            favoriteManager.add(league: league)
        }
    }
}
