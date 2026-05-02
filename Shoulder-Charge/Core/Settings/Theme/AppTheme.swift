//
//  ThemeManager.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 28/04/2026.
//

import UIKit

enum AppTheme: String, CaseIterable {
    case system, light, dark

    var displayName: String {
        switch self {
        case .system: return "System"
        case .light:  return "Light"
        case .dark:   return "Dark"
        }
    }

    var interfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .system: return .unspecified
        case .light:  return .light
        case .dark:   return .dark
        }
    }
}

final class ThemeManager {
    static let shared = ThemeManager()
    private init() {}

    private let themeKey = "app_theme"

    var currentTheme: AppTheme {
        get {
            let raw = UserDefaults.standard.string(forKey: themeKey) ?? AppTheme.system.rawValue
            return AppTheme(rawValue: raw) ?? .system
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: themeKey)
            applyTheme()
        }
    }

    func applyTheme(to window: UIWindow?) {
        window?.overrideUserInterfaceStyle = currentTheme.interfaceStyle
    }

    func applyTheme() {
        let style = currentTheme.interfaceStyle
        let windows = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
        windows.forEach { window in
            UIView.transition(with: window,
                              duration: 0.35,
                              options: [.transitionFlipFromLeft, .allowUserInteraction]) {
                window.overrideUserInterfaceStyle = style
            }
        }
    }
}
