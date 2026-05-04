//
//  PlayerDetailsPresenterProtocol.swift
//  Shoulder-Charge
//

protocol PlayerDetailsPresenterProtocol {
    func viewDidLoad()
    func getLeagueName() -> String
    func getPlayer() -> TennisPlayerModel?
}
