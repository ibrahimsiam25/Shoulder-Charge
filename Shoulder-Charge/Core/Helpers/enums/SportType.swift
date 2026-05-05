//
//  SportType.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 29/04/2026.
//


enum SportType:String {
    case football, basketball, tennis, cricket

    var apiPath: String {
        switch self {
        case .football:    return "football"
        case .basketball:  return "basketball"
        case .tennis:      return "tennis"
        case .cricket:     return "cricket"
        }
    }
    
    var image: String {
        switch self {
        case .football:    return "FootballHome"
        case .basketball:  return "BasketballHome"
        case .tennis:      return "TennisHome"
        case .cricket:     return "CricketHome"
        }
    }

    var title: String {
        switch self {
        case .football:    return L10n.Home.soccer
        case .basketball:  return L10n.Home.basket
        case .tennis:      return L10n.Home.tennis
        case .cricket:     return L10n.Home.racquet
        }
    }
}
