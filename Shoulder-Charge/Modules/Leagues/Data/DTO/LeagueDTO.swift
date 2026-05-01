//
//  LeagueDTO.swift
//  Shoulder-Charge
//

import Foundation

protocol LeagueMappable {
    var leagueKey: Int { get }
    var leagueName: String { get }
    var leagueLogoURLString: String? { get }
    var displaySubTitle: String? { get }
    var sport: SportType { get }
}

extension LeagueMappable {
    func toDomain() -> UnifiedLeagueModel {
        UnifiedLeagueModel(
            id: leagueKey,
            name: leagueName,
            logoURL: leagueLogoURLString.flatMap { URL(string: $0) },
            displaySubTitle: displaySubTitle,
            sport: sport
        )
    }
}

struct FootballLeagueDTO: Decodable, LeagueMappable {
    let leagueKey: Int
    let leagueName: String
    let leagueLogo: String?
    let countryName: String?

    enum CodingKeys: String, CodingKey {
        case leagueKey   = "league_key"
        case leagueName  = "league_name"
        case leagueLogo  = "league_logo"
        case countryName = "country_name"
    }

    var leagueLogoURLString: String? { leagueLogo }
    var displaySubTitle: String? { countryName }
    var sport: SportType { .football }
}

struct BasketballLeagueDTO: Decodable, LeagueMappable {
    let leagueKey: Int
    let leagueName: String
    let countryName: String?

    enum CodingKeys: String, CodingKey {
        case leagueKey   = "league_key"
        case leagueName  = "league_name"
        case countryName = "country_name"
    }

    var leagueLogoURLString: String? { nil }
    var displaySubTitle: String? { countryName }
    var sport: SportType { .basketball }
}

struct CricketLeagueDTO: Decodable, LeagueMappable {
    let leagueKey: Int
    let leagueName: String
    let leagueYear: String?

    enum CodingKeys: String, CodingKey {
        case leagueKey  = "league_key"
        case leagueName = "league_name"
        case leagueYear = "league_year"
    }

    var leagueLogoURLString: String? { nil }
    var displaySubTitle: String? { leagueYear }
    var sport: SportType { .cricket }
}

struct TennisLeagueDTO: Decodable, LeagueMappable {
    let leagueKey: Int
    let leagueName: String
    let countryName: String?
    let leagueSurface: String?

    enum CodingKeys: String, CodingKey {
        case leagueKey     = "league_key"
        case leagueName    = "league_name"
        case countryName   = "country_name"
        case leagueSurface = "league_surface"
    }

    var leagueLogoURLString: String? { nil }
    var displaySubTitle: String? { countryName }
    var sport: SportType { .tennis }
}
