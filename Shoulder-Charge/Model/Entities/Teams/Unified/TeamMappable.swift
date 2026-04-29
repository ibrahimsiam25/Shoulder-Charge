//
//  TeamMappable.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 29/04/2026.
//

import Foundation

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
