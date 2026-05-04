import Foundation

enum LeagueDetailsSection: Int, CaseIterable {
    case upcoming = 0
    case past = 1
    case participants = 2
}

protocol LeagueDetailsPresenterProtocol {
    func viewDidLoad()
    

    func numberOfSections() -> Int
    func getSectionType(at index: Int) -> LeagueDetailsSection
    func getPastEventsCount() -> Int
    func getUpcomingEventsCount() -> Int
    func getParticipantsCount() -> Int
    func getAllPastEvents() -> [UnifiedEventModel]
    func getPastEvent(at index: Int) -> UnifiedEventModel
    func getUpcomingEvent(at index: Int) -> UnifiedEventModel
    func getParticipant(at index: Int) -> LeagueParticipantDisplayModel
    
 
    func getTitleForSection(at index: Int) -> String
    func getLeagueName() -> String
    func getLeagueLogo() -> URL?
    func getSportType() -> SportType
    func isFavoriteLeague() -> Bool
    func toggleFavorite()
    func didSelectParticipant(at index: Int, from view: LeagueDetailsViewProtocol)
}
