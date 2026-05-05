//
//  TeamQueryParams.swift
//  Shoulder-Charge
//
//  Created by siam on 05/05/2026.
//

class TeamQueryParams: LeagueQueryParams {

    private(set) var leagueId: String
    private(set) var teamId: String

    init(met: String, leagueId: String, teamId: String, apiKey: String = Constants.apiKey) {
        self.leagueId = leagueId
        self.teamId = teamId
        super.init(met: met, apiKey: apiKey)
    }

    override var asDictionary: [String: String] {
        var dict = super.asDictionary
        dict["leagueId"] = leagueId
        dict["teamId"] = teamId
        return dict
    }
}
