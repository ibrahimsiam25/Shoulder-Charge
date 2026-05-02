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
        case .upcoming:     return presenter.getUpcomingEventsCount()
        case .past:         return presenter.getPastEventsCount() > 0 ? 1 : 0
        case .participants: return presenter.getParticipantsCount()
        }
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = presenter.getSectionType(at: indexPath.section)
        
        switch sectionType {
        case .upcoming:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LeagueDetailsCollectionViewController.reuseIdentifierUpComing, for: indexPath
            ) as! UpComingEventsCollectionViewCell
            cell.configure(with: presenter.getUpcomingEvent(at: indexPath.item))
            return cell

        case .past:
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
}
