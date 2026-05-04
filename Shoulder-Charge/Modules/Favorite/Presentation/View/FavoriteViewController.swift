import UIKit

private let cellId = "leagueCell"

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    
    var presenter: FavoritePresenterProtocol!
    
    private let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Favorites.empty
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        title = "Favorites"
        
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.backgroundColor = .clear
        favoriteTableView.separatorStyle = .none
        favoriteTableView.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        view.addSubview(emptyStateLabel)
        NSLayoutConstraint.activate([
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension FavoriteViewController: FavoriteViewProtocol {
    func reloadTableData() {
        favoriteTableView.reloadData()
    }
    
    func toggleEmptyState(visible: Bool) {
        emptyStateLabel.isHidden = !visible
        favoriteTableView.isHidden = visible
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LeagueTableViewCell
        let league = presenter.getItem(at: indexPath.row)
        cell.configure(with: league, showsFavorite: false, isFavorite: true)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteFavorite(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.navigateToLeagueDetails(at: indexPath.row)
    }
}
