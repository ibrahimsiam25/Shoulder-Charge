//
//  LeagueDetailsPresenter.swift
//  Shoulder-Charge
//

import Foundation

@MainActor
class LeagueDetailsPresenter: LeagueDetailsPresenterProtocol {

    private let repository: LeagueDetailsRepositoryProtocol
    private weak var view: LeagueDetailsViewProtocol?
    private let leagueId: String
    private let sport: SportType

    private var pastEvents: [UnifiedEventModel] = []
    private var upcomingEvents: [UnifiedEventModel] = []
    private var participants: [LeagueParticipantDisplayModel] = []

    init(
        repository: LeagueDetailsRepositoryProtocol,
        view: LeagueDetailsViewProtocol,
        leagueId: String,
        sport: SportType
    ) {
        self.repository = repository
        self.view = view
        self.leagueId = leagueId
        self.sport = sport
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

    func getPastEventsCount() -> Int       { pastEvents.count }
    func getUpcomingEventsCount() -> Int   { upcomingEvents.count }
    func getParticipantsCount() -> Int     { participants.count }
    
    func getAllPastEvents() -> [UnifiedEventModel] { pastEvents }

    func getPastEvent(at index: Int) -> UnifiedEventModel          { pastEvents[index] }
    func getUpcomingEvent(at index: Int) -> UnifiedEventModel      { upcomingEvents[index] }
    func getParticipant(at index: Int) -> LeagueParticipantDisplayModel { participants[index] }
}
