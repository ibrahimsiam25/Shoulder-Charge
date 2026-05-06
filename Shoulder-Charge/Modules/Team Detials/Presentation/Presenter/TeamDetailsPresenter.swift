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
    private let imageValidator = TeamPlayerImageValidator()
    
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
                prepareLineup(for: team.players)
            } catch {
                view?.toggleLoading(false)
                view?.showError(error.localizedDescription)
            }
        }
    }
    
    func getTeam() -> TeamModel? {
        return team
    }

    private func prepareLineup(for players: [PlayerItem]) {
        view?.toggleLoading(true)
        imageValidator.validate(players: players) { [weak self] validImagePlayerKeys in
            guard let self else { return }
            self.view?.toggleLoading(false)
            let output = self.makeLineupData(players: players, validImagePlayerKeys: validImagePlayerKeys)
            self.view?.showLineup(output.lineup, substituteSections: output.sections)
        }
    }

    private func makeLineupData(
        players: [PlayerItem],
        validImagePlayerKeys: Set<Int>
    ) -> (lineup: LineupViewModel, sections: [PlayerSectionViewModel]) {
        let goalkeepers = sortedPlayersByImagePreference(
            players.filter { $0.positionLine == .goalkeeper },
            validImagePlayerKeys: validImagePlayerKeys
        )
        let defenders = sortedPlayersByImagePreference(
            players.filter { $0.positionLine == .defender },
            validImagePlayerKeys: validImagePlayerKeys
        )
        let midfielders = sortedPlayersByImagePreference(
            players.filter { $0.positionLine == .midfielder },
            validImagePlayerKeys: validImagePlayerKeys
        )
        var forwards = sortedPlayersByImagePreference(
            players.filter { $0.positionLine == .forward || $0.positionLine == .striker },
            validImagePlayerKeys: validImagePlayerKeys
        )

        let striker = pickStriker(from: &forwards)
        let gk = goalkeepers.first
        let def1 = player(at: 0, in: defenders)
        let def2 = player(at: 1, in: defenders)
        let def3 = player(at: 2, in: defenders)
        let def4 = player(at: 3, in: defenders)
        let mid1 = player(at: 0, in: midfielders)
        let mid2 = player(at: 1, in: midfielders)
        let mid3 = player(at: 2, in: midfielders)
        let fwd1 = player(at: 0, in: forwards)
        let fwd2 = player(at: 1, in: forwards)

        var assignedKeys = Set<Int>()
        addAssignedKey(from: gk, to: &assignedKeys)
        addAssignedKey(from: def1, to: &assignedKeys)
        addAssignedKey(from: def2, to: &assignedKeys)
        addAssignedKey(from: def3, to: &assignedKeys)
        addAssignedKey(from: def4, to: &assignedKeys)
        addAssignedKey(from: mid1, to: &assignedKeys)
        addAssignedKey(from: mid2, to: &assignedKeys)
        addAssignedKey(from: mid3, to: &assignedKeys)
        addAssignedKey(from: fwd1, to: &assignedKeys)
        addAssignedKey(from: fwd2, to: &assignedKeys)
        addAssignedKey(from: striker, to: &assignedKeys)

        let lineup = LineupViewModel(
            gk: gk.map { makeLineupCardViewModel($0, positionTitle: "GK") },
            def1: def1.map { makeLineupCardViewModel($0, positionTitle: "DEF") },
            def2: def2.map { makeLineupCardViewModel($0, positionTitle: "DEF") },
            def3: def3.map { makeLineupCardViewModel($0, positionTitle: "DEF") },
            def4: def4.map { makeLineupCardViewModel($0, positionTitle: "DEF") },
            mid1: mid1.map { makeLineupCardViewModel($0, positionTitle: "MID") },
            mid2: mid2.map { makeLineupCardViewModel($0, positionTitle: "MID") },
            mid3: mid3.map { makeLineupCardViewModel($0, positionTitle: "MID") },
            fwd1: fwd1.map { makeLineupCardViewModel($0, positionTitle: "FWD") },
            fwd2: fwd2.map { makeLineupCardViewModel($0, positionTitle: "FWD") },
            st: striker.map { makeLineupCardViewModel($0, positionTitle: "ST") }
        )

        let substitutes = players.filter { !assignedKeys.contains($0.playerKey) }
        let sections = makeSubstituteSections(from: substitutes)
        return (lineup, sections)
    }

    private func makeLineupCardViewModel(
        _ player: PlayerItem,
        positionTitle: String
    ) -> LineupCardViewModel {
        LineupCardViewModel(
            imageURL: player.imageURL,
            name: player.name,
            positionTitle: positionTitle,
            number: player.number
        )
    }

    private func makeSubstituteSections(from players: [PlayerItem]) -> [PlayerSectionViewModel] {
        let sections: [(PositionLine, String)] = [
            (.goalkeeper, L10n.TeamDetails.goalkeepers),
            (.defender, L10n.TeamDetails.defenders),
            (.midfielder, L10n.TeamDetails.midfielders),
            (.forward, L10n.TeamDetails.forwards)
        ]

        return sections.compactMap { line, title in
            let sectionPlayers = players.filter { player in
                if line == .forward {
                    return player.positionLine == .forward || player.positionLine == .striker
                }
                return player.positionLine == line
            }

            guard !sectionPlayers.isEmpty else { return nil }
            let rows = sectionPlayers.map { player in
                PlayerRowViewModel(
                    name: player.name,
                    position: player.position,
                    imageURL: player.imageURL
                )
            }
            return PlayerSectionViewModel(title: title, players: rows)
        }
    }

    private func pickStriker(from forwards: inout [PlayerItem]) -> PlayerItem? {
        if let index = forwards.firstIndex(where: {
            Int($0.number.trimmingCharacters(in: .whitespacesAndNewlines)) == 10
        }) {
            return forwards.remove(at: index)
        }

        return forwards.isEmpty ? nil : forwards.removeFirst()
    }

    private func sortedPlayersByImagePreference(
        _ players: [PlayerItem],
        validImagePlayerKeys: Set<Int>
    ) -> [PlayerItem] {
        players.enumerated().sorted { lhs, rhs in
            let lhsValid = validImagePlayerKeys.contains(lhs.element.playerKey)
            let rhsValid = validImagePlayerKeys.contains(rhs.element.playerKey)

            if lhsValid != rhsValid {
                return lhsValid
            }

            let lhsHasImage = lhs.element.imageURL != nil
            let rhsHasImage = rhs.element.imageURL != nil

            if lhsHasImage != rhsHasImage {
                return lhsHasImage
            }

            return lhs.offset < rhs.offset
        }.map { $0.element }
    }

    private func player(at index: Int, in players: [PlayerItem]) -> PlayerItem? {
        guard index >= 0, index < players.count else { return nil }
        return players[index]
    }

    private func addAssignedKey(from player: PlayerItem?, to assignedKeys: inout Set<Int>) {
        guard let player else { return }
        assignedKeys.insert(player.playerKey)
    }
}
