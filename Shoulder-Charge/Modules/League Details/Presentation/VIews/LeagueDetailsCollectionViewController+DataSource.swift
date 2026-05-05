//
//  LeagueDetailsCollectionViewController+DataSource.swift
//  Shoulder-Charge
//
//  Created by siam on 02/05/2026.
//

import UIKit


extension LeagueDetailsCollectionViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections()
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        let sectionType = presenter.getSectionType(at: section)
        switch sectionType {
        case .upcoming:
            guard isDataLoaded else { return 0 }
            let upcomingEventsCount = presenter.getUpcomingEventsCount()
            return upcomingEventsCount > 0 ? upcomingEventsCount : 1
        case .past:
            guard isDataLoaded else { return 0 }
            return 1
        case .participants: return presenter.getParticipantsCount()
        }
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = presenter.getSectionType(at: indexPath.section)
        
        switch sectionType {
        case .upcoming:
            if presenter.getUpcomingEventsCount() == 0 {
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: LeagueDetailsCollectionViewController.reuseIdentifierEmptyState,
                    for: indexPath
                ) as! LeagueDetailsEmptyStateCollectionViewCell
                cell.configure(
                    title: L10n.LeagueDetails.noUpcomingEventsTitle,
                    subtitle: L10n.LeagueDetails.noUpcomingEventsSubtitle
                )
                return cell
            }
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LeagueDetailsCollectionViewController.reuseIdentifierUpComing, for: indexPath
            ) as! UpComingEventsCollectionViewCell
            cell.configure(with: presenter.getUpcomingEvent(at: indexPath.item))
            return cell

        case .past:
            if presenter.getPastEventsCount() == 0 {
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: LeagueDetailsCollectionViewController.reuseIdentifierEmptyState,
                    for: indexPath
                ) as! LeagueDetailsEmptyStateCollectionViewCell
                cell.configure(
                    title: L10n.LeagueDetails.noFinishedEventsTitle,
                    subtitle: L10n.LeagueDetails.noFinishedEventsSubtitle
                )
                return cell
            }
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LeagueDetailsCollectionViewController.containerReuseIdentifier, for: indexPath
            ) as! FinishedEventsContainerCell
            cell.configure(with: presenter.getAllPastEvents())
            return cell

        case .participants:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LeagueDetailsCollectionViewController.reuseIdentifierParticipant, for: indexPath
            ) as! LeagueParticipantCollectionViewCell
            cell.configure(with: presenter.getParticipant(at: indexPath.item))
            return cell
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
            withReuseIdentifier: LeagueDetailsCollectionViewController.headerReuseIdentifier,
            for: indexPath
        ) as! SectionHeaderView
        
        if !isDataLoaded {
            header.titleLabel.text = ""
            return header
        }
        
        header.titleLabel.text = presenter.getTitleForSection(at: indexPath.section)
        return header
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = presenter.getSectionType(at: indexPath.section)
        guard sectionType == .participants else { return }
        presenter.didSelectParticipant(at: indexPath.item, from: self)
    }
}
