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
        view?.updateThemeSwitch(isDark: ThemeManager.shared.currentTheme == .dark)
        view?.updateLanguageLabel(LocalizationManager.shared.currentAppLanguage)
    }

    func userDidToggleTheme(isDark: Bool) {
        ThemeManager.shared.currentTheme = isDark ? .dark : .system
    }

    func userDidSelectLanguage(_ language: AppLanguage) {
        LocalizationManager.shared.setLanguage(language)
        view?.updateLanguageLabel(language)
    }
}
