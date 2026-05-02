//
//  SettingsPresenter.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 28/04/2026.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {
    func updateThemeSwitch(isDark: Bool)
    func updateLanguageLabel(_ language: AppLanguage)
}

class SettingsPresenter {
    weak var view: SettingsViewProtocol?

    func viewDidLoad() {
        let isDark = ThemeManager.shared.currentTheme == .dark
        view?.updateThemeSwitch(isDark: isDark)
        view?.updateLanguageLabel(LocalizationManager.shared.currentAppLanguage)
    }

    func userDidToggleTheme(isDark: Bool) {
        ThemeManager.shared.currentTheme = isDark ? .dark : .light
    }

    func userDidSelectLanguage(_ language: AppLanguage) {
        LocalizationManager.shared.setLanguage(language)
        view?.updateLanguageLabel(language)
    }
}
