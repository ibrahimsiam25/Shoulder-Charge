//
//  LocalizationManager.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 28/04/2026.
//

import UIKit
import Localize_Swift

extension Notification.Name {
    static let languageChanged = Notification.Name(LCLLanguageChangeNotification)
}

final class LocalizationManager {
    static let shared = LocalizationManager()
    private init() {}

    var currentLanguage: String {
        Localize.currentLanguage()
    }

    var currentAppLanguage: AppLanguage {
        AppLanguage(rawValue: Localize.currentLanguage()) ?? .system
    }

    // MARK: - Layout Direction
    func applyLayoutDirection() {
        let isRTL = Locale.characterDirection(forLanguage: currentLanguage) == .rightToLeft
        let attribute: UISemanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
        UIView.appearance().semanticContentAttribute = attribute
        UINavigationBar.appearance().semanticContentAttribute = attribute
        let backChevron = UIImage(systemName: isRTL ? "chevron.forward" : "chevron.backward")
        UINavigationBar.appearance().backIndicatorImage = backChevron
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backChevron
        UITabBar.appearance().semanticContentAttribute = attribute
        UIToolbar.appearance().semanticContentAttribute = attribute
        UISearchBar.appearance().semanticContentAttribute = attribute;
        UISegmentedControl.appearance().semanticContentAttribute = attribute
        UITableView.appearance().semanticContentAttribute = attribute
        UICollectionView.appearance().semanticContentAttribute = attribute
    }

    // MARK: - Switching

    func setLanguage(_ appLanguage: AppLanguage) {
        if let code = appLanguage.code {
            guard code != Localize.currentLanguage() else { return }
            Localize.setCurrentLanguage(code)
        } else {
            Localize.resetCurrentLanguageToDefault()
        }
    }
}
