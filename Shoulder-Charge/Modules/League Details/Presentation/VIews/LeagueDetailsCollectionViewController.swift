//
//  LeagueDetailsCollectionViewController.swift
//  Shoulder-Charge
//
//  Created by siam on 01/05/2026.
//

import UIKit

// MARK: - Reuse Identifiers
private let reuseIdentifierFinished    = "FinishedEventsCollectionViewCell"
private let reuseIdentifierUpComing    = "UpComingEventsCollectionViewCell"
private let reuseIdentifierParticipant = "LeagueParticipantCollectionViewCell"

// MARK: - LeagueDetailsCollectionViewController
class LeagueDetailsCollectionViewController: UICollectionViewController, LeagueDetailsViewProtocol {

    // MARK: - Properties
    var presenter: LeagueDetailsPresenterProtocol!

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
        setupLayout()
        setupLoadingIndicator()
        presenter.viewDidLoad()
    }

    // MARK: - Setup
    private func setupCells() {
        let nibs = [
            reuseIdentifierUpComing,
            reuseIdentifierFinished,
            reuseIdentifierParticipant
        ]
        nibs.forEach {
            collectionView.register(UINib(nibName: $0, bundle: nil), forCellWithReuseIdentifier: $0)
        }
    }

    private func setupLayout() {
        let layout = UICollectionViewCompositionalLayout { index, _ in
            switch index {
            case 0:  return self.makeHorizontalScrollSection()
            case 1:  return self.makeHorizontalScrollSection()
            case 2:  return self.makeHorizontalScrollSection()
            default: return self.makeHorizontalScrollSection()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: false)
    }

    private func setupLoadingIndicator() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - Section Layout Factory
    private func makeHorizontalScrollSection() -> NSCollectionLayoutSection {
        let itemSize  = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        let item      = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75),
                                               heightDimension: .absolute(200))
        let group     = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 100, leading: 100, bottom: 40, trailing: 40)
        return section
    }

    // MARK: - LeagueDetailsViewProtocol
    func reloadData() {
        collectionView.reloadData()
    }

    func toggleLoading(_ val: Bool) {
        val ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        collectionView.isUserInteractionEnabled = !val
    }
}

// MARK: - UICollectionViewDataSource
extension LeagueDetailsCollectionViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:  return presenter.getUpcomingEventsCount()
        case 1:  return presenter.getPastEventsCount()
        case 2:  return presenter.getParticipantsCount()
        default: return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {

        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: reuseIdentifierUpComing, for: indexPath
            ) as! UpComingEventsCollectionViewCell
            cell.configure(with: presenter.getUpcomingEvent(at: indexPath.item))
            return cell

        case 1:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: reuseIdentifierFinished, for: indexPath
            ) as! FinishedEventsCollectionViewCell
            cell.configure(with: presenter.getPastEvent(at: indexPath.item))
            return cell

        case 2:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: reuseIdentifierParticipant, for: indexPath
            ) as! LeagueParticipantCollectionViewCell
            cell.configure(with: presenter.getParticipant(at: indexPath.item))
            return cell

        default:
            fatalError("Invalid section")
        }
    }
}
