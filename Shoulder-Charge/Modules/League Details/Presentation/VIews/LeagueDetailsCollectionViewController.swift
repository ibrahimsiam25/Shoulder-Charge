//
//  LeagueDetailsCollectionViewController.swift
//  Shoulder-Charge
//
//  Created by siam on 01/05/2026.
//

import UIKit

// MARK: - Reuse Identifiers
private let reuseIdentifierFinished    = "finishedCell"
private let reuseIdentifierUpComing    = "upcomingCell"
private let reuseIdentifierParticipant = "LeagueParticipantCollectionViewCell"
private let containerReuseIdentifier   = "FinishedEventsContainerCell"
private let headerReuseIdentifier      = "SectionHeaderView"

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
        collectionView.register(UINib(nibName: "UpComingEventsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifierUpComing)
        collectionView.register(UINib(nibName: "FinishedEventsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifierFinished)
        collectionView.register(UINib(nibName: "LeagueParticipantCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifierParticipant)
        collectionView.register(FinishedEventsContainerCell.self, forCellWithReuseIdentifier: containerReuseIdentifier)
        
        collectionView.register(SectionHeaderView.self, 
                              forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, 
                              withReuseIdentifier: headerReuseIdentifier)
    }

    private func setupLayout() {
        let layout = UICollectionViewCompositionalLayout { index, _ in
            switch index {
            case 0:  return self.makeHorizontalSection(height: 200, itemWidth: 0.85, title: "Upcoming Events")
            case 1:  return self.makeVerticalContainerSection()
            case 2:  return self.makeHorizontalSection(height: 150, itemWidth: 0.3, title: "League Participants")
            default: return self.makeHorizontalSection(height: 200, itemWidth: 0.85, title: "")
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
    private func makeHorizontalSection(height: CGFloat, itemWidth: CGFloat, title: String) -> NSCollectionLayoutSection {
        let itemSize  = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        let item      = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemWidth),
                                               heightDimension: .absolute(height))
        let group     = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 8, bottom: 20, trailing: 8)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
        return section
    }

    private func makeVerticalContainerSection() -> NSCollectionLayoutSection {
        let screenHeight = UIScreen.main.bounds.height
        let sectionHeight = screenHeight * 0.3
        
        let itemSize  = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        let item      = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(sectionHeight))
        let group     = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
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
        case 1:  return presenter.getPastEventsCount() > 0 ? 1 : 0
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
                withReuseIdentifier: containerReuseIdentifier, for: indexPath
            ) as! FinishedEventsContainerCell
            cell.configure(with: presenter.getAllPastEvents())
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

    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: headerReuseIdentifier,
            for: indexPath
        ) as! SectionHeaderView
        
        switch indexPath.section {
        case 0: header.titleLabel.text = "Upcoming Events"
        case 1: header.titleLabel.text = "Finished Events"
        case 2: header.titleLabel.text = "League Participants"
        default: header.titleLabel.text = ""
        }
        
        return header
    }
}

// MARK: - SectionHeaderView
class SectionHeaderView: UICollectionReusableView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
