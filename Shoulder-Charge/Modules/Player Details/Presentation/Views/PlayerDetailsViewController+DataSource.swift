//
//  PlayerDetailsViewController+DataSource.swift
//  Shoulder-Charge
//

import UIKit

extension PlayerDetailsViewController {

    // MARK: - Sections & Items

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return PlayerDetailsSection.allCases.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        guard let player = presenter.getPlayer() else { return 0 }
        let sectionType = PlayerDetailsSection(rawValue: section) ?? .header
        switch sectionType {
        case .header:      return 1
        case .stats:       return player.stats.count
        case .tournaments: return player.tournaments.count
        }
    }

    // MARK: - Cells

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = PlayerDetailsSection(rawValue: indexPath.section) ?? .header

        switch sectionType {
        case .header:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Self.reuseHeader, for: indexPath
            ) as! PlayerHeaderCell
            if let player = presenter.getPlayer() {
                cell.configure(with: player, leagueName: presenter.getLeagueName())
            }
            return cell

        case .stats:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Self.reuseStat, for: indexPath
            ) as! PlayerStatSeasonCard
            if let player = presenter.getPlayer() {
                cell.configure(with: player.stats[indexPath.item])
            }
            return cell

        case .tournaments:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Self.reuseTournament, for: indexPath
            ) as! PlayerTournamentCell
            if let player = presenter.getPlayer() {
                cell.configure(with: player.tournaments[indexPath.item])
            }
            return cell
        }
    }

    // MARK: - Supplementary (Section Headers)

    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: Self.reuseSection,
            for: indexPath
        ) as! SectionHeaderView

        let sectionType = PlayerDetailsSection(rawValue: indexPath.section) ?? .header
        switch sectionType {
        case .header:
            header.titleLabel.text = ""
        case .stats:
            header.titleLabel.text = L10n.PlayerDetails.stats
        case .tournaments:
            header.titleLabel.text = L10n.PlayerDetails.tournaments
        }
        return header
    }
}
