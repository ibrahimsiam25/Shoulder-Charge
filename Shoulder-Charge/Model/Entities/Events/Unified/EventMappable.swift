// MARK: - Event Protocol

protocol EventMappable {
    var eventKey: String? { get }
    var eventDate: String? { get }
    var eventTime: String? { get }
    var eventHomeTeam: String? { get }
    var eventAwayTeam: String? { get }
    var homeTeamLogoString: String? { get }
    var awayTeamLogoString: String? { get }
    var eventFinalResult: String? { get }
    var eventStatus: String? { get }
    var leagueName: String? { get }
    var leagueRound: String? { get }
    var leagueSeason: String? { get }
}

extension EventMappable {
    func toDisplayModel() -> UnifiedEventModel {
        UnifiedEventModel(
            eventKey: eventKey,
            date: eventDate,
            time: eventTime,
            homeTeam: eventHomeTeam,
            awayTeam: eventAwayTeam,
            homeTeamLogo: homeTeamLogoString.flatMap { URL(string: $0) },
            awayTeamLogo: awayTeamLogoString.flatMap { URL(string: $0) },
            result: eventFinalResult,
            status: eventStatus,
            leagueName: leagueName,
            leagueRound: leagueRound,
            leagueSeason: leagueSeason
        )
    }
}

// MARK: - Team Protocol

protocol TeamMappable {
    var teamKey: String? { get }
    var teamName: String? { get }
    var teamLogoString: String? { get }
    var countryName: String? { get }
}

extension TeamMappable {
    func toDisplayModel() -> UnifiedTeamModel {
        UnifiedTeamModel(
            teamKey: teamKey,
            teamName: teamName,
            teamLogo: teamLogoString.flatMap { URL(string: $0) },
            countryName: countryName
        )
    }
}