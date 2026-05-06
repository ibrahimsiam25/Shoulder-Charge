import UIKit
import SDWebImage

class TeamDetilasViewController: UIViewController, TeamDetailsViewProtocol {

    var presenter: TeamDetailsPresenterProtocol!
    private var substituteSections: [PlayerSectionViewModel] = []
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
    }

    func showLineup(_ lineup: LineupViewModel, substituteSections: [PlayerSectionViewModel]) {
        applyLineup(lineup)
        self.substituteSections = substituteSections
        tableView.reloadData()
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
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

    private func applyLineup(_ lineup: LineupViewModel) {
        resetLineupCards()
        applyLineupCard(lineup.gk, to: gkView)
        applyLineupCard(lineup.def1, to: def1View)
        applyLineupCard(lineup.def2, to: def2View)
        applyLineupCard(lineup.def3, to: def3View)
        applyLineupCard(lineup.def4, to: def4View)
        applyLineupCard(lineup.mid1, to: mid1View)
        applyLineupCard(lineup.mid2, to: mid2View)
        applyLineupCard(lineup.mid3, to: mid3View)
        applyLineupCard(lineup.fwd1, to: fwd1View)
        applyLineupCard(lineup.fwd2, to: fwd2View)
        applyLineupCard(lineup.st, to: stView)
    }

    private func applyLineupCard(_ viewModel: LineupCardViewModel?, to view: PlayerCardView) {
        if let viewModel {
            view.config(
                imageURL: viewModel.imageURL?.absoluteString,
                playerName: viewModel.name,
                playerPosition: viewModel.positionTitle,
                playerNumber: viewModel.number
            )
        } else {
            view.config(imageURL: nil, playerName: nil, playerPosition: nil, playerNumber: nil)
        }
        view.isHidden = false
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
