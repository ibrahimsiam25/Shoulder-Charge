////
////  AppSettingsCoordinator.swift
////  Shoulder-Charge
////
////  Created by Eslam Elnady on 28/04/2026.
////
//
//
//final class AppSettingsCoordinator {
//    static let shared = AppSettingsCoordinator()
//    private init() {}
//    
//    private let themeManager = ThemeManager.shared
//    private let localizationManager = LocalizationManager.shared
//    
//    // MARK: - Setup at Launch
//    func bootstrap(window: UIWindow?) {
//        themeManager.applyTheme(to: window)
//        localizationManager.applyCurrentLanguage()
//    }
//    
//    // MARK: - Theme
//    var isDarkMode: Bool { themeManager.isDark }
//    
//    func setTheme(dark: Bool) {
//        themeManager.isDark = dark
//        themeManager.applyTheme()
//    }
//    
//    // MARK: - Localization
//    var currentLanguage: String { localizationManager.currentLanguage }
//    
//    func setLanguage(_ language: String) {
//        localizationManager.currentLanguage = language
//    }
//}
