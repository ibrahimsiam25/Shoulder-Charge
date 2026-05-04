//
//  PlayerDetailsViewProtocol.swift
//  Shoulder-Charge
//

protocol PlayerDetailsViewProtocol: AnyObject {
    func toggleLoading(_ isLoading: Bool)
    func showPlayerDetails(_ player: TennisPlayerModel)
    func showError(_ message: String)
}
