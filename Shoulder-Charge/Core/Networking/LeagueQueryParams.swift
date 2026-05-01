//
//  LeagueQueryParams.swift
//  Shoulder-Charge
//

class LeagueQueryParams {

    private(set) var met: String
    private(set) var apiKey: String

    init(met: String, apiKey: String = Constants.apiKey) {
        self.met = met
        self.apiKey = apiKey
    }

    var asDictionary: [String: String] {
        ["met": met, "APIkey": apiKey]
    }
}
