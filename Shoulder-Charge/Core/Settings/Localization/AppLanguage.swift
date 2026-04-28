//
//  AppLanguage.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 28/04/2026.
//

import Foundation

enum AppLanguage: String, CaseIterable {
    case system, en, ar

    var displayName: String {
        switch self {
        case .system: return L10n.Settings.Language.system
        case .en:     return "English"
        case .ar:     return "العربية"
        }
    }

    var code: String? {
        switch self {
        case .system: return nil
        case .en:     return "en"
        case .ar:     return "ar"
        }
    }
}
