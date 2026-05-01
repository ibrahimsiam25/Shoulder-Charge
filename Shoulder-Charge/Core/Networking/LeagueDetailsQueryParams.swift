//
//  LeagueDetailsQueryParams.swift
//  Shoulder-Charge
//

class LeagueDetailsQueryParams: LeagueQueryParams {

    private(set) var leagueId: String
    private(set) var from: String?
    private(set) var to: String?

    init(met: String, leagueId: String, from: String? = nil, to: String? = nil, apiKey: String = Constants.apiKey) {
        self.leagueId = leagueId
        self.from = from
        self.to = to
        super.init(met: met, apiKey: apiKey)
    }

    override var asDictionary: [String: String] {
        var dict = super.asDictionary
        dict["leagueId"] = leagueId
        if let from { dict["from"] = from }
        if let to   { dict["to"]   = to   }
        return dict
    }
}
