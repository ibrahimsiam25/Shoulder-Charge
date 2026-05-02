//
//  LanguageCell.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 02/05/2026.
//

import UIKit

class LanguageCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!

    func configure(with presenter: SettingsPresenterProtocol) {
        let language = presenter.currentAppLanguage()
        titleLabel.text = L10n.Settings.language
        detailLabel.text = language.displayName

        let isRTL: Bool
        if let code = language.code {
            isRTL = Locale.characterDirection(forLanguage: code) == .rightToLeft
        } else {
            isRTL = false
        }
        let dir: UISemanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
        semanticContentAttribute = dir
        contentView.semanticContentAttribute = dir
        [titleLabel, detailLabel].forEach {
            $0?.semanticContentAttribute = dir
            $0?.textAlignment = .natural
        }
    }
}
