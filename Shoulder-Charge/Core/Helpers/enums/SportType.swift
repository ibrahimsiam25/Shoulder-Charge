//
//  SportType.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 29/04/2026.
//


enum SportType {
    case football, basketball, tennis, cricket

    var apiPath: String {
        switch self {
        case .football:    return "football"
        case .basketball:  return "basketball"
        case .tennis:      return "tennis"
        case .cricket:     return "cricket"
        }
    }
}