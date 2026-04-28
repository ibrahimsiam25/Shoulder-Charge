//
//  L10n.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 28/04/2026.
//
//  Type-safe localization key namespace.
//  All properties are computed vars so they re-evaluate after a language switch.
//
//  Usage:
//    label.text = L10n.Settings.title
//    label.text = L10n.Settings.Theme.dark
//

import Foundation

enum L10n {

    enum Settings {
        static var title:    String { "settings.title".localized }
        static var theme:    String { "settings.theme".localized }
        static var language: String { "settings.language".localized }

        enum Theme {
            static var system: String { "settings.theme.system".localized }
            static var light:  String { "settings.theme.light".localized }
            static var dark:   String { "settings.theme.dark".localized }
        }

        enum Language {
            static var system:  String { "settings.language.system".localized }
            static var english: String { "settings.language.english".localized }
            static var arabic:  String { "settings.language.arabic".localized }
        }
    }

    enum Common {
        static var done:   String { "common.done".localized }
        static var cancel: String { "common.cancel".localized }
        static var save:   String { "common.save".localized }
    }
}
