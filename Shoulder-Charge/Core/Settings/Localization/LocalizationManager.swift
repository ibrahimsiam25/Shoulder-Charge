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
          UITabBar.appearance().semanticContentAttribute = attribute
          UIToolbar.appearance().semanticContentAttribute = attribute
          UISearchBar.appearance().semanticContentAttribute = attribute
          UISegmentedControl.appearance().semanticContentAttribute = attribute
          UITableView.appearance().semanticContentAttribute = attribute
          UICollectionView.appearance().semanticContentAttribute = attribute
          let backChevron = UIImage(systemName: isRTL ? "chevron.forward" : "chevron.backward")
          
          let navAppearance = UINavigationBarAppearance()
          navAppearance.configureWithTransparentBackground()
          navAppearance.setBackIndicatorImage(backChevron, transitionMaskImage: backChevron)
          
          UINavigationBar.appearance().standardAppearance = navAppearance
          UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
          UINavigationBar.appearance().compactAppearance = navAppearance
    }
   var localizedBundle: Bundle {
        let lang = currentLanguage
        if let path = Bundle.main.path(forResource: lang, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return bundle
        }
        return .main
    }


    func swizzleBundleForCurrentLanguage() {
        Bundle.setLanguage(currentLanguage)
    }



    func setLanguage(_ appLanguage: AppLanguage) {
        if let code = appLanguage.code {
            guard code != Localize.currentLanguage() else { return }
            Localize.setCurrentLanguage(code)
        } else {
            Localize.resetCurrentLanguageToDefault()
        }

        swizzleBundleForCurrentLanguage()
    }
    
    func makeNavigationBarAppearance(backgroundColor: UIColor? = nil) -> UINavigationBarAppearance {
        let isRTL = Locale.characterDirection(forLanguage: currentLanguage) == .rightToLeft
        let backChevron = UIImage(systemName: isRTL ? "chevron.forward" : "chevron.backward")
        
        let appearance = UINavigationBarAppearance()
        if let bgColor = backgroundColor {
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = bgColor
        } else {
            appearance.configureWithTransparentBackground()
        }
        appearance.shadowColor = .clear
        appearance.setBackIndicatorImage(backChevron, transitionMaskImage: backChevron)
        
        return appearance
    }
    
    
}
