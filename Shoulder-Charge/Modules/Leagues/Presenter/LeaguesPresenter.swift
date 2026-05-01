//
//  LeaguesPresenter.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 01/05/2026.
//
import Foundation

class LeaguesPresenter : LeaguesPresenterProtocol{

    private var leagueService: LeagueService!
    private var view: LeaguesViewProtocol!
    private var router: LeaguesRouterProtocol!
    private var leagues: [UnifiedLeagueModel] = []
    private var filteredLeagues: [UnifiedLeagueModel] = []
    
    init(leagueService: LeagueService!, view: LeaguesViewProtocol!, router: LeaguesRouterProtocol!) {
        self.leagueService = leagueService
        self.view = view
        self.router = router
    }
    
    func viewDidLoad(){
        view.toggleLoading(true)
        leagueService.fetchLeagues(sport: .football) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                self.view.toggleLoading(false)
                do {
                    self.leagues = try result.get()
                    self.filteredLeagues = self.leagues
                    self.view.reloadTableData()
                } catch let error {
                    print("error while fetching leagues: \(error)")
                }
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
        let leagueId = filteredLeagues[index].id
        router.navigateToLeagueDetails(with: leagueId, from: view)
    }
    
    
}
