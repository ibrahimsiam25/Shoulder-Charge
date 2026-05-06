//
//  TeamDetailsViewProtocol.swift
//  Shoulder-Charge
//
//  Created by siam on 05/05/2026.
//

import Foundation

protocol TeamDetailsViewProtocol: AnyObject {
    func toggleLoading(_ isLoading: Bool)
    func showTeamDetails(_ team: TeamModel)
    func showLineup(_ lineup: LineupViewModel, substituteSections: [PlayerSectionViewModel])
    func showError(_ message: String)
}
