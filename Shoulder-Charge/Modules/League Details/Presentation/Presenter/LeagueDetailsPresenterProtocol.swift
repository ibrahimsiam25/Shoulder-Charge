//
//  LeagueDetailsPresenterProtocol.swift
//  Shoulder-Charge
//

protocol LeagueDetailsPresenterProtocol {
    func viewDidLoad()
    func getPastEventsCount() -> Int
    func getUpcomingEventsCount() -> Int
    func getParticipantsCount() -> Int
    func getPastEvent(at index: Int) -> UnifiedEventModel
    func getUpcomingEvent(at index: Int) -> UnifiedEventModel
    func getParticipant(at index: Int) -> LeagueParticipantDisplayModel
}
