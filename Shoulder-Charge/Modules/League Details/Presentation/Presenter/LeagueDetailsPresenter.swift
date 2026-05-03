//
//  LeagueDetailsPresenter.swift
//  Shoulder-Charge
//

import Foundation

@MainActor
class LeagueDetailsPresenter: LeagueDetailsPresenterProtocol {

    private let repository: LeagueDetailsRepositoryProtocol
    private weak var view: LeagueDetailsViewProtocol?
    private let router: LeagueDetailsRouterProtocol
    private let leagueId: String
    private let sport: SportType
    private let leagueName: String
    private let leagueLogo: URL?

    private var pastEvents: [UnifiedEventModel] = []
    private var upcomingEvents: [UnifiedEventModel] = []
    private var participants: [LeagueParticipantDisplayModel] = []

    init(
        repository: LeagueDetailsRepositoryProtocol,
        view: LeagueDetailsViewProtocol,
        router: LeagueDetailsRouterProtocol,
        leagueId: String,
        sport: SportType,
        leagueName: String,
        leagueLogo: URL?
    ) {
        self.repository = repository
        self.view = view
        self.router = router
        self.leagueId = leagueId
        self.sport = sport
        self.leagueName = leagueName
        self.leagueLogo = leagueLogo
    }

    func viewDidLoad() {
        view?.toggleLoading(true)
        Task {
            do {
                async let past         = repository.getPastEvents(sport: sport, leagueId: leagueId)
                async let upcoming     = repository.getUpcomingEvents(sport: sport, leagueId: leagueId)
                async let participants = repository.getParticipants(sport: sport, leagueId: leagueId)

                let (pastResult, upcomingResult, participantsResult) = try await (past, upcoming, participants)
                
                self.pastEvents    = pastResult
                self.upcomingEvents = upcomingResult
                self.participants  = participantsResult
                
                if self.pastEvents.isEmpty && self.upcomingEvents.isEmpty {
                    print("DEBUG: API returned 0 events for league \(self.leagueId). Adding mock data for layout verification.")
                    self.addMockData()
                }
                
                view?.toggleLoading(false)
                view?.reloadData()
            } catch {
                view?.toggleLoading(false)
                print("DEBUG: Error fetching league details: \(error)")
                // Add mock data on error too to see if layout works
                self.addMockData()
                view?.reloadData()
            }
        }
    }

    private func addMockData() {
        let mockEvent = UnifiedEventModel(
            eventKey: 1,
            date: "2026-05-10",
            time: "18:00",
            homeTeam: "Mock Home Team",
            awayTeam: "Mock Away Team",
            homeTeamLogo: nil,
            awayTeamLogo: nil,
            result: "2 - 1",
            status: "Upcoming",
            leagueName: "Mock League",
            leagueRound: "Final",
            leagueSeason: "2026"
        )
        self.upcomingEvents = [mockEvent, mockEvent, mockEvent]
        self.pastEvents = [mockEvent, mockEvent]
    }

    func numberOfSections() -> Int {
        return LeagueDetailsSection.allCases.count
    }
    
    func getSectionType(at index: Int) -> LeagueDetailsSection {
        return LeagueDetailsSection(rawValue: index) ?? .upcoming
    }

    func getPastEventsCount() -> Int       { pastEvents.count }
    func getUpcomingEventsCount() -> Int   { upcomingEvents.count }
    func getParticipantsCount() -> Int     { participants.count }
    
    func getAllPastEvents() -> [UnifiedEventModel] { pastEvents }

    func getPastEvent(at index: Int) -> UnifiedEventModel          { pastEvents[index] }
    func getUpcomingEvent(at index: Int) -> UnifiedEventModel      { upcomingEvents[index] }
    func getParticipant(at index: Int) -> LeagueParticipantDisplayModel { participants[index] }
    
    func getTitleForSection(at index: Int) -> String {
        guard let section = LeagueDetailsSection(rawValue: index) else { return "" }
        
        switch section {
        case .upcoming:
            return upcomingEvents.count > 0 ? L10n.LeagueDetails.upcoming : ""
        case .past:
            return pastEvents.count > 0 ? L10n.LeagueDetails.finished : ""
        case .participants:
            if participants.count > 0 {
                return sport == .tennis ? L10n.LeagueDetails.players : L10n.LeagueDetails.teams
            }
            return ""
        }
    }

    func getLeagueName() -> String { leagueName }
    func getLeagueLogo() -> URL? { leagueLogo }
    func getSportType() -> SportType { sport }
    
    func isFavoriteLeague() -> Bool {
        let favorites = UserDefaults.standard.stringArray(forKey: "favorites") ?? []
        return favorites.contains(leagueId)
    }
    
    func toggleFavorite() {
        var favorites = UserDefaults.standard.stringArray(forKey: "favorites") ?? []
        if let index = favorites.firstIndex(of: leagueId) {
            favorites.remove(at: index)
        } else {
            favorites.append(leagueId)
        }
        UserDefaults.standard.set(favorites, forKey: "favorites")
    }
}
