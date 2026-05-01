//
//  LeaguesViewController.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 01/05/2026.
//

import UIKit

private let cellId = "leagueCell"
class LeaguesViewController: UIViewController {
    
    @IBOutlet weak var leaguesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var leaguesTableView: UITableView!
    var leaguesPresenter: LeaguesPresenterProtocol!

    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        leaguesPresenter.viewDidLoad()
    }

    func setupUI()  {
        leaguesLabel.text = L10n.Leagues.title
        searchBar.placeholder = L10n.Leagues.searchPlaceholder
        leaguesTableView.delegate = self
        leaguesTableView.dataSource = self
        leaguesTableView.backgroundView = nil
        leaguesTableView.backgroundColor = .clear
        leaguesTableView.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)

        loadingIndicator.color = UIColor(named: "Primary")
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        leaguesTableView.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: leaguesTableView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: leaguesTableView.centerYAnchor)
        ])
    }
}

extension LeaguesViewController : LeaguesViewProtocol{
    func reloadTableData() {
        leaguesTableView.reloadData()
    }

    func toggleLoading(_ val: Bool) {
        if val {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
}

 // MARK: - DATA SOURCE
extension LeaguesViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesPresenter.getItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LeagueTableViewCell
        let leagueModel = leaguesPresenter.getItem(at: indexPath.row)
        cell.configure(with: leagueModel)
        return cell
    }
    
    
}

// MARK: - UI DELEGATE

extension LeaguesViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        leaguesPresenter.navigateToLeagueDetails(at: indexPath.row)
    }
}
