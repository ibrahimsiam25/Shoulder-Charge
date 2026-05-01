//
//  ParticipantMappable.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 29/04/2026.
//

import Foundation


protocol ParticipantMappable {
    var participantKey: Int? { get }
    var participantName: String? { get }
    var participantLogoURLString: String? { get }
    var participantSubtitle: String? { get }
}

extension ParticipantMappable {
    func toParticipantDisplayModel() -> LeagueParticipantDisplayModel {
        LeagueParticipantDisplayModel(
            key: participantKey,
            name: participantName,
            logoURL: participantLogoURLString.flatMap { URL(string: $0) },
            subtitle: participantSubtitle
        )
    }
}
