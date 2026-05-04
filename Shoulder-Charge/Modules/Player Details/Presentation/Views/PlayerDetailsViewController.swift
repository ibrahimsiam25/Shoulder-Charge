//
//  PlayerDetailsViewController.swift
//  Shoulder-Charge
//

import UIKit
import SDWebImage

class PlayerDetailsViewController: UICollectionViewController, PlayerDetailsViewProtocol {

    static let reuseHeader      = "PlayerHeaderCell"
    static let reuseStat        = "PlayerStatSeasonCard"
    static let reuseTournament  = "PlayerTournamentCell"
    static let reuseSection     = "SectionHeaderView"

    var presenter: PlayerDetailsPresenterProtocol!

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCells()
        setupLoadingIndicator()
        collectionView.backgroundColor = UIColor(named: "Background")
        collectionView.collectionViewLayout = createLayout()
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        setupNavigationBar()
    }

    // MARK: - Setup

    private func setupCells() {
        collectionView.register(UINib(nibName: "PlayerHeaderCell", bundle: nil), forCellWithReuseIdentifier: Self.reuseHeader)
        collectionView.register(UINib(nibName: "PlayerStatSeasonCard", bundle: nil), forCellWithReuseIdentifier: Self.reuseStat)
        collectionView.register(PlayerTournamentCell.self, forCellWithReuseIdentifier: Self.reuseTournament)
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: Self.reuseSection
        )
    }

    private func setupLoadingIndicator() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupNavigationBar() {
        let appearance = LocalizationManager.shared.makeNavigationBarAppearance(
            backgroundColor: UIColor(named: "Background")
        )
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "Background") ?? UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 1)
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(named: "Primary") ?? UIColor.systemGreen,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        navigationController?.navigationBar.tintColor = UIColor(named: "Primary") ?? .systemGreen
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance

        let titleLabel = UILabel()
        titleLabel.text = presenter.getPlayer()?.playerName ?? presenter.getLeagueName()
        titleLabel.textColor = UIColor(named: "Primary") ?? .systemGreen
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        navigationItem.titleView = titleLabel
        navigationItem.backButtonDisplayMode = .minimal
    }

    // MARK: - PlayerDetailsViewProtocol

    func toggleLoading(_ isLoading: Bool) {
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        collectionView.isUserInteractionEnabled = !isLoading
    }

    func showPlayerDetails(_ player: TennisPlayerModel) {
        setupNavigationBar()
        collectionView.reloadData()
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
