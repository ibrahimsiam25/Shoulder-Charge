//
//  ComingSoonAlert.swift
//  Shoulder-Charge
//
//  Created by siam on 09/05/2026.
//

import UIKit

extension LeagueDetailsCollectionViewController {

    func showComingSoonAlert() {

        let alert = UIAlertController(
            title: L10n.LeagueDetails.featureComingSoonTitle,
            message: L10n.LeagueDetails.featureComingSoonMessage,
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(
                title: L10n.Common.ok,
                style: .default
            )
        )

        present(alert, animated: true)
    }
}
