//
//  LeaguesPresenter.swift
//  Shoulder-Charge
//
import Foundation

@MainActor
class LeaguesPresenter: LeaguesPresenterProtocol {

    private let repository: LeaguesRepositoryProtocol
    private var view: LeaguesViewProtocol!
    private var router: LeaguesRouterProtocol!
    private var leagues: [UnifiedLeagueModel] = []
    private var filteredLeagues: [UnifiedLeagueModel] = []

    init(repository: LeaguesRepositoryProtocol, view: LeaguesViewProtocol!, router: LeaguesRouterProtocol!) {
        self.repository = repository
        self.view = view
        self.router = router
    }

    func viewDidLoad() {
        view.toggleLoading(true)
        Task {
            do {
                let result = try await repository.getLeagues(sport: .football)
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
        router.navigateToLeagueDetails(with: league.id, sport: league.sport, from: view)
    }
}
