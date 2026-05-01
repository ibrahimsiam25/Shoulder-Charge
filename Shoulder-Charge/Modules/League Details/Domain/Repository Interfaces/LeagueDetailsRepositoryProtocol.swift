//
//  LeagueDetailsRepositoryProtocol.swift
//  Shoulder-Charge
//

protocol LeagueDetailsRepositoryProtocol {
    func getPastEvents(sport: SportType, leagueId: String) async throws -> [UnifiedEventModel]
    func getUpcomingEvents(sport: SportType, leagueId: String) async throws -> [UnifiedEventModel]
    func getParticipants(sport: SportType, leagueId: String) async throws -> [LeagueParticipantDisplayModel]
}
