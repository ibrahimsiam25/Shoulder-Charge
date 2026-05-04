//
//  PlayerQueryParams.swift
//  Shoulder-Charge
//

class PlayerQueryParams: LeagueQueryParams {

    private(set) var leagueId: String
    private(set) var playerId: String

    init(met: String, leagueId: String, playerId: String, apiKey: String = Constants.apiKey) {
        self.leagueId = leagueId
        self.playerId = playerId
        super.init(met: met, apiKey: apiKey)
    }

    override var asDictionary: [String: String] {
        var dict = super.asDictionary
        dict["leagueId"] = leagueId
        dict["playerId"] = playerId
        return dict
    }
}
