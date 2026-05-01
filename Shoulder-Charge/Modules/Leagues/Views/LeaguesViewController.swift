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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaguesLabel.text = L10n.Leagues.title
        searchBar.placeholder = L10n.Leagues.searchPlaceholder
        leaguesTableView.delegate = self
        leaguesTableView.dataSource = self
        leaguesTableView.backgroundView = nil
        leaguesTableView.backgroundColor = .clear
        leaguesTableView.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
    

}
extension LeaguesViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LeagueTableViewCell
       let leagueModel = UnifiedLeagueModel(id: 1, name: "UEFA Europa League", logoURL: URL(string: "https://apiv2.allsportsapi.com/logo/logo_leagues/3_uefa_champions_league.png")!, displaySubTitle: "Egypt")
        cell.configure(with: leagueModel)
        return cell
    }
    
    
}
extension LeaguesViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
