struct BasketballTeam: Decodable, TeamMappable {
    let teamKey: String?
    let teamName: String?
    let teamLogo: String?
    let countryName: String?

    enum CodingKeys: String, CodingKey {
        case teamKey     = "team_key"
        case teamName    = "team_name"
        case teamLogo    = "team_logo"
        case countryName = "team_country"
    }

    var teamLogoString: String? { teamLogo }
}