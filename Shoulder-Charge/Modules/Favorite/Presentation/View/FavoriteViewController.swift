import UIKit

private let cellId = "leagueCell"

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var presenter: FavoritePresenterProtocol!
    private var isPerformingBatchDelete = false

    // MARK: – Empty State
    private lazy var emptyStateView: UIView = {
        let container = UIView()
        container.isHidden = true
        container.translatesAutoresizingMaskIntoConstraints = false

        // Icon
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 72, weight: .thin)
        let iconImage = UIImage(systemName: "star.slash.fill", withConfiguration: iconConfig)
        let iconView = UIImageView(image: iconImage)
        iconView.tintColor = UIColor(named: "Primary")
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false

        // Title
        let titleLabel = UILabel()
        titleLabel.text = L10n.Favorites.emptyTitle
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(named: "Text Primary")
        titleLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        // Subtitle
        let subtitleLabel = UILabel()
        subtitleLabel.text = L10n.Favorites.emptySubtitle
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = UIColor(named: "Text Sec")
        subtitleLabel.font = .systemFont(ofSize: 15, weight: .regular)
        subtitleLabel.numberOfLines = 2
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        // Stack
        let stack = UIStackView(arrangedSubviews: [iconView, titleLabel, subtitleLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(stack)
        NSLayoutConstraint.activate([
            iconView.heightAnchor.constraint(equalToConstant: 80),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -32),
            stack.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            stack.centerXAnchor.constraint(equalTo: container.centerXAnchor)
        ])

        return container
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        if presenter == nil {
            presenter = FavoritePresenter(view: self, router: FavoriteRouter())
        }
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
        
        let appearance = LocalizationManager.shared.makeNavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private func setupUI() {
        title = L10n.Favorites.title
        searchBar.placeholder = L10n.Leagues.searchPlaceholder
        searchBar.delegate = self

        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.backgroundColor = .clear
        favoriteTableView.separatorStyle = .none
        favoriteTableView.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)

        view.addSubview(emptyStateView)
        NSLayoutConstraint.activate([
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FavoriteViewController: FavoriteViewProtocol {
    func reloadTableData() {
        guard !isPerformingBatchDelete else { return }
        favoriteTableView.reloadData()
    }
    
    func toggleEmptyState(visible: Bool) {
        emptyStateView.isHidden = !visible
        favoriteTableView.isHidden = visible
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.getSectionsCount()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getItemsCount(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LeagueTableViewCell
        let league = presenter.getItem(section: indexPath.section, row: indexPath.row)
        cell.configure(with: league, showsFavorite: false, isFavorite: true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let sectionWillBeEmpty = presenter.getItemsCount(in: indexPath.section) == 1
            isPerformingBatchDelete = true
            presenter.deleteFavorite(section: indexPath.section, row: indexPath.row)
            isPerformingBatchDelete = false
            tableView.performBatchUpdates({
                tableView.deleteRows(at: [indexPath], with: .fade)
                if sectionWillBeEmpty {
                    tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
                }
            }, completion: nil)
        }
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear

        let label = UILabel()
        label.text = presenter.getSectionTitle(at: section)
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "Text Primary")
        label.translatesAutoresizingMaskIntoConstraints = false

        headerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -4)
        ])

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.navigateToLeagueDetails(section: indexPath.section, row: indexPath.row)
    }
}

extension FavoriteViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.filterFavorites(by: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        presenter.filterFavorites(by: "")
    }
}
