//
//  UnifidLeagueModel.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 29/04/2026.
//

import Foundation

struct UnifiedLeagueModel {
    let id: String
    let name: String
    let logoURL: URL?
}

protocol LeagueMappable {
    var leagueKey: String { get }
    var leagueName: String { get }
    var leagueLogoURLString: String? { get }
}


extension LeagueMappable {
    func toDisplayModel() -> UnifiedLeagueModel {
        UnifiedLeagueModel(
            id: leagueKey,
            name: leagueName,
            logoURL: leagueLogoURLString.flatMap { URL(string: $0) }
        )
    }
}


struct FootballLeague: Decodable, LeagueMappable {
    let leagueKey: String
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
}

struct BasketballLeague: Decodable, LeagueMappable {
    let leagueKey: String
    let leagueName: String
    let countryName: String?

    enum CodingKeys: String, CodingKey {
        case leagueKey   = "league_key"
        case leagueName  = "league_name"
        case countryName = "country_name"
    }

    var leagueLogoURLString: String? { nil }
}

struct CricketLeague: Decodable, LeagueMappable {
    let leagueKey: String
    let leagueName: String
    let leagueYear: String?

    enum CodingKeys: String, CodingKey {
        case leagueKey  = "league_key"
        case leagueName = "league_name"
        case leagueYear = "league_year"
    }

    var leagueLogoURLString: String? { nil }
}

struct TennisLeague: Decodable, LeagueMappable {
    let leagueKey: String
    let leagueName: String
    let tournamentType: String?
    let leagueSurface: String?

    enum CodingKeys: String, CodingKey {
        case leagueKey      = "league_key"
        case leagueName     = "league_name"
        case tournamentType = "country_name"
        case leagueSurface  = "league_surface"
    }

    var leagueLogoURLString: String? { nil }
}
