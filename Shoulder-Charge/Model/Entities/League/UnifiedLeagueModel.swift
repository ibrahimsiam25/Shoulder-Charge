//
//  UnifidLeagueModel.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 29/04/2026.
//

import Foundation

struct UnifiedLeagueModel {
    let id: Int
    let name: String
    let logoURL: URL?
    let displaySubTitle: String?
}

protocol LeagueMappable {
    var leagueKey: Int { get }
    var leagueName: String { get }
    var leagueLogoURLString: String? { get }
    var displaySubTitle: String? { get }
}


extension LeagueMappable {
    func toDisplayModel() -> UnifiedLeagueModel {
        UnifiedLeagueModel(
            id: leagueKey,
            name: leagueName,
            logoURL: leagueLogoURLString.flatMap { URL(string: $0) },
            displaySubTitle: displaySubTitle
        )
    }
}


struct FootballLeague: Decodable, LeagueMappable {
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
    var displaySubTitle: String? {countryName}
}

struct BasketballLeague: Decodable, LeagueMappable {
    let leagueKey: Int
    let leagueName: String
    let countryName: String?

    enum CodingKeys: String, CodingKey {
        case leagueKey   = "league_key"
        case leagueName  = "league_name"
        case countryName = "country_name"
    }

    var leagueLogoURLString: String? { nil }
    var displaySubTitle: String? {countryName}

}

struct CricketLeague: Decodable, LeagueMappable {
    let leagueKey: Int
    let leagueName: String
    let leagueYear: String?

    enum CodingKeys: String, CodingKey {
        case leagueKey  = "league_key"
        case leagueName = "league_name"
        case leagueYear = "league_year"
    }

    var leagueLogoURLString: String? { nil }
    var displaySubTitle: String? {leagueYear}
}

struct TennisLeague: Decodable, LeagueMappable {
    let leagueKey: Int
    let leagueName: String
    let countryName: String?
    let leagueSurface: String?

    enum CodingKeys: String, CodingKey {
        case leagueKey      = "league_key"
        case leagueName     = "league_name"
        case countryName = "country_name"
        case leagueSurface  = "league_surface"
    }

    var leagueLogoURLString: String? { nil }
    var displaySubTitle: String? {countryName}

}
