//
//  PlayerDetailsPresenter.swift
//  Shoulder-Charge
//

import Foundation

@MainActor
class PlayerDetailsPresenter: PlayerDetailsPresenterProtocol {

    private let repository: PlayerDetailsRepositoryProtocol
    private weak var view: PlayerDetailsViewProtocol?
    private let sport: SportType
    private let playerId: String
    private let leagueId: String
    private let leagueName: String
    private var player: TennisPlayerModel?

    init(
        repository: PlayerDetailsRepositoryProtocol,
        view: PlayerDetailsViewProtocol,
        router: PlayerDetailsRouter,
        sport: SportType,
        playerId: String,
        leagueId: String,
        leagueName: String
    ) {
        self.repository = repository
        self.view = view
        self.sport = sport
        self.playerId = playerId
        self.leagueId = leagueId
        self.leagueName = leagueName
    }

    func viewDidLoad() {
        view?.toggleLoading(true)
        Task {
            do {
                let player = try await repository.getPlayerDetails(sport: sport, leagueId: leagueId, playerId: playerId)
                self.player = player
                view?.toggleLoading(false)
                view?.showPlayerDetails(player)
            } catch {
                view?.toggleLoading(false)
                view?.showError(error.localizedDescription)
            }
        }
    }

    func getLeagueName() -> String {
        leagueName
    }

    func getPlayer() -> TennisPlayerModel? {
        player
    }
}
