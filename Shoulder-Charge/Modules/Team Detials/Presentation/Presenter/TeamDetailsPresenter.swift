//
//  TeamDetailsPresenter.swift
//  Shoulder-Charge
//
//  Created by siam on 05/05/2026.
//

import Foundation

@MainActor
class TeamDetailsPresenter: TeamDetailsPresenterProtocol {
    
    private let repository: TeamDetailsRepositoryProtocol
    private weak var view: TeamDetailsViewProtocol?
    private let router: TeamDetailsRouterProtocol
    private let sport: SportType
    private let teamId: String
    private let leagueId: String
    private var team: TeamModel?
    
    init(
        repository: TeamDetailsRepositoryProtocol,
        view: TeamDetailsViewProtocol,
        router: TeamDetailsRouterProtocol,
        sport: SportType,
        teamId: String,
        leagueId: String
    ) {
        self.repository = repository
        self.view = view
        self.router = router
        self.sport = sport
        self.teamId = teamId
        self.leagueId = leagueId
    }
    
    func viewDidLoad() {
        view?.toggleLoading(true)
        Task {
            do {
                let team = try await repository.getTeamDetails(sport: sport, leagueId: leagueId, teamId: teamId)
                self.team = team
                view?.toggleLoading(false)
                view?.showTeamDetails(team)
            } catch {
                view?.toggleLoading(false)
                view?.showError(error.localizedDescription)
            }
        }
    }
    
    func getTeam() -> TeamModel? {
        return team
    }
}
