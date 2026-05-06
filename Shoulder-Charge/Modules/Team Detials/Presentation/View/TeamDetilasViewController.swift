import UIKit
import SDWebImage

class TeamDetilasViewController: UIViewController, TeamDetailsViewProtocol {

    typealias Player = PlayerItem

    var presenter: TeamDetailsPresenterProtocol!
    private var substitutePlayers: [PlayerItem] = []
    private var substituteSections: [PlayerSection] = []
    private var validImagePlayerKeys = Set<Int>()
    private let imageValidator = TeamPlayerImageValidator()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var teamLogoImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var coachNameLabel: UILabel!
    @IBOutlet weak var stadiumImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?

    @IBOutlet weak var gkView: PlayerCardView!
    @IBOutlet weak var def1View: PlayerCardView!
    @IBOutlet weak var def2View: PlayerCardView!
    @IBOutlet weak var def3View: PlayerCardView!
    @IBOutlet weak var def4View: PlayerCardView!
    @IBOutlet weak var mid1View: PlayerCardView!
    @IBOutlet weak var mid2View: PlayerCardView!
    @IBOutlet weak var mid3View: PlayerCardView!
    @IBOutlet weak var fwd1View: PlayerCardView!
    @IBOutlet weak var fwd2View: PlayerCardView!
    @IBOutlet weak var stView: PlayerCardView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        setupNavigationBar()
    }

    private func setupUI() {
        view.backgroundColor = UIColor(named: "Background")
        teamNameLabel.textColor = UIColor(named: "Text Primary")
        coachNameLabel.textColor = UIColor(named: "Primary")
        activityIndicator?.isHidden = true
        setupTableView()
        setupPlayerCards()
        setupLoadingIndicator()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "PlayerListTableViewCell", bundle: nil),
            forCellReuseIdentifier: PlayerListTableViewCell.reuseIdentifier
        )
        tableView.backgroundColor = UIColor(named: "Background")
        tableView.separatorStyle = .none
    }

    private func setupLoadingIndicator() {
        loadingIndicator.color = UIColor(named: "Primary")
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        ])
    }

    private func setupNavigationBar() {
        title = ""
        let appearance = LocalizationManager.shared.makeNavigationBarAppearance(
            backgroundColor: UIColor(named: "Background")
        )
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = UIColor(named: "Primary")
    }

    private func setupPlayerCards() {
        stadiumImageView.superview?.clipsToBounds = false
        allCardViews.forEach {
            $0.clipsToBounds = false
            $0.layer.masksToBounds = false
        }
    }

    func toggleLoading(_ isLoading: Bool) {
        isLoading ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
    }

    func showTeamDetails(_ team: TeamModel) {
        teamNameLabel.text = team.teamName
        coachNameLabel.text = "Coach: \(team.coachName)"
        teamLogoImageView.sd_setImage(with: team.teamLogoURL)

        toggleLoading(true)
        imageValidator.validate(players: team.players) { [weak self] validImagePlayerKeys in
            guard let self else { return }
            self.toggleLoading(false)
            self.validImagePlayerKeys = validImagePlayerKeys
            self.configureLineup(players: team.players)
        }
    }

    func configureLineup(players: [Player]) {
        resetLineupCards()

        let goalkeepers = sortedPlayersByImagePreference(
            players.filter { $0.positionLine == .goalkeeper }
        )
        let defenders = sortedPlayersByImagePreference(
            players.filter { $0.positionLine == .defender }
        )
        let midfielders = sortedPlayersByImagePreference(
            players.filter { $0.positionLine == .midfielder }
        )
        var forwards = sortedPlayersByImagePreference(
            players.filter { $0.positionLine == .forward || $0.positionLine == .striker }
        )

        let striker = pickStriker(from: &forwards)
        var assignedKeys = Set<Int>()

        if let goalkeeper = goalkeepers.first {
            apply(player: goalkeeper, to: gkView, positionTitle: "GK")
            assignedKeys.insert(goalkeeper.playerKey)
        }

        assign(players: defenders, to: defenderViews, positionTitle: "DEF", assignedKeys: &assignedKeys)
        assign(players: midfielders, to: midfielderViews, positionTitle: "MID", assignedKeys: &assignedKeys)

        if let striker {
            apply(player: striker, to: stView, positionTitle: "ST")
            assignedKeys.insert(striker.playerKey)
        }

        assign(players: forwards, to: forwardViews, positionTitle: "FWD", assignedKeys: &assignedKeys)

        substitutePlayers = players.filter { !assignedKeys.contains($0.playerKey) }
        substituteSections = makeSubstituteSections(from: substitutePlayers)
        tableView.reloadData()
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private var defenderViews: [PlayerCardView] {
        [def1View, def2View, def3View, def4View]
    }

    private var midfielderViews: [PlayerCardView] {
        [mid1View, mid2View, mid3View]
    }

    private var forwardViews: [PlayerCardView] {
        [fwd1View, fwd2View]
    }

    private var allCardViews: [PlayerCardView] {
        [
            gkView,
            def1View,
            def2View,
            def3View,
            def4View,
            mid1View,
            mid2View,
            mid3View,
            fwd1View,
            fwd2View,
            stView
        ]
    }

    private func resetLineupCards() {
        allCardViews.forEach { card in
            card.config(imageURL: nil, playerName: nil, playerPosition: nil, playerNumber: nil)
            card.isHidden = false
        }
    }

    private func assign(
        players: [Player],
        to views: [PlayerCardView],
        positionTitle: String,
        assignedKeys: inout Set<Int>
    ) {
        for (view, player) in zip(views, players) {
            apply(player: player, to: view, positionTitle: positionTitle)
            assignedKeys.insert(player.playerKey)
        }
    }

    private func apply(player: Player, to view: PlayerCardView, positionTitle: String) {
        view.config(
            imageURL: player.imageURL?.absoluteString,
            playerName: player.name,
            playerPosition: positionTitle,
            playerNumber: player.number
        )
        view.isHidden = false
    }

    private func pickStriker(from forwards: inout [Player]) -> Player? {
        if let index = forwards.firstIndex(where: {
            Int($0.number.trimmingCharacters(in: .whitespacesAndNewlines)) == 10
        }) {
            return forwards.remove(at: index)
        }

        return forwards.isEmpty ? nil : forwards.removeFirst()
    }

    private func sortedPlayersByImagePreference(_ players: [Player]) -> [Player] {
        players.enumerated().sorted { lhs, rhs in
            let lhsValid = hasValidImage(lhs.element)
            let rhsValid = hasValidImage(rhs.element)

            if lhsValid != rhsValid {
                return lhsValid
            }

            let lhsHasImage = lhs.element.imageURL != nil
            let rhsHasImage = rhs.element.imageURL != nil

            if lhsHasImage != rhsHasImage {
                return lhsHasImage
            }

            return lhs.offset < rhs.offset
        }.map { $0.element }
    }

    private func hasValidImage(_ player: Player) -> Bool {
        validImagePlayerKeys.contains(player.playerKey)
    }

    private func makeSubstituteSections(from players: [Player]) -> [PlayerSection] {
        let sections: [(PositionLine, String)] = [
            (.goalkeeper, L10n.TeamDetails.goalkeepers),
            (.defender, L10n.TeamDetails.defenders),
            (.midfielder, L10n.TeamDetails.midfielders),
            (.forward, L10n.TeamDetails.forwards)
        ]

        return sections.compactMap { line, title in
            let sectionPlayers = players.filter {
                if line == .forward {
                    return $0.positionLine == .forward || $0.positionLine == .striker
                }
                return $0.positionLine == line
            }
            return sectionPlayers.isEmpty ? nil : PlayerSection(title: title, players: sectionPlayers)
        }
    }

    private struct PlayerSection {
        let title: String
        let players: [Player]
    }
}

extension TeamDetilasViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        substituteSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        substituteSections[section].players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerListTableViewCell.reuseIdentifier, for: indexPath) as! PlayerListTableViewCell
        cell.configure(with: substituteSections[indexPath.section].players[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        substituteSections[section].title
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor(named: "Text Primary")
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        header.contentView.backgroundColor = UIColor(named: "Background")
    }
}
