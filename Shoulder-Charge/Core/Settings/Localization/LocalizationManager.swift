////
////  LocalizationManager.swift
////  Shoulder-Charge
////
////  Created by Eslam Elnady on 28/04/2026.
////
//
//import Foundation
//
//
//final class LocalizationManager {
//    static let shared = LocalizationManager()
//    
//    private let languageKey = "app_language"
//    
//    var currentLanguage: String {
//        get { UserDefaults.standard.string(forKey: languageKey) ?? Locale.preferredLanguages.first ?? "en" }
//        set {
//            UserDefaults.standard.set(newValue, forKey: languageKey)
//            Bundle.setLanguage(newValue)
//            NotificationCenter.default.post(name: .languageChanged, object: nil)
//        }
//    }
//}
