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
    private let favoriteManager:FavoriteManagerProtocol
    
    private var pastEvents: [UnifiedEventModel] = []
    private var upcomingEvents: [UnifiedEventModel] = []
    private var participants: [LeagueParticipantDisplayModel] = []
    private var isFavorite = false
    init(
        repository: LeagueDetailsRepositoryProtocol,
        view: LeagueDetailsViewProtocol,
        router: LeagueDetailsRouterProtocol,
        leagueId: String,
        sport: SportType,
        leagueName: String,
        leagueLogo: URL?,
        favoriteManager:FavoriteManagerProtocol
    ) {
        self.repository = repository
        self.view = view
        self.router = router
        self.leagueId = leagueId
        self.sport = sport
        self.leagueName = leagueName
        self.leagueLogo = leagueLogo
        self.favoriteManager = favoriteManager
    }

    func viewDidLoad() {
        view?.toggleLoading(true)
        isFavorite =  favoriteManager.isExist(id: Int(leagueId)!)
        Task {
            do {
                async let past         = repository.getPastEvents(sport: sport, leagueId: leagueId)
                async let upcoming     = repository.getUpcomingEvents(sport: sport, leagueId: leagueId)
                async let participants = repository.getParticipants(sport: sport, leagueId: leagueId)

                let (pastResult, upcomingResult, participantsResult) = try await (past, upcoming, participants)
                
                self.pastEvents    = pastResult
                self.upcomingEvents = upcomingResult
                self.participants  = participantsResult
                
                view?.toggleLoading(false)
                view?.reloadData()
            } catch let error{
                print("error : \(error.localizedDescription)")
                view?.toggleLoading(false)
                view?.reloadData()
            }
        }
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
            return L10n.LeagueDetails.upcoming
        case .past:
            return L10n.LeagueDetails.finished
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
       return isFavorite
    }
    
    func toggleFavorite() {
        if isFavorite {
            favoriteManager.delete(id: Int(leagueId)!)
            isFavorite.toggle()
        } else{
            favoriteManager.add(league:UnifiedLeagueModel(
                id: Int(leagueId)!,
                name: leagueName,
                logoURL: leagueLogo,
                displaySubTitle: nil,
                sport: sport
            ))
            isFavorite.toggle()
        }
    }

    func didSelectParticipant(at index: Int, from view: LeagueDetailsViewProtocol) {
        guard sport == .tennis else { return }
        let participant = participants[index]
        guard let playerId = participant.key else { return }
        router.navigateToPlayerDetails(
            playerId: String(playerId),
            leagueId: leagueId,
            leagueName: leagueName,
            sport: sport,
            from: view
        )
    }
}
