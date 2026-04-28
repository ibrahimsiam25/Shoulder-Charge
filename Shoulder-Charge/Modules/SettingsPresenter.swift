//
//  SettingsPresenter.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 28/04/2026.
//

import UIKit

class SettingsPresenter {
    weak var view: SettingsViewProtocol?

    func viewDidLoad() {
        view?.updateThemeSelection(theme: ThemeManager.shared.currentTheme)
        view?.updateLanguageSelection(language: LocalizationManager.shared.currentAppLanguage)
    }

    func userDidSelectTheme(_ theme: AppTheme) {
        ThemeManager.shared.currentTheme = theme
    }

    func userDidSelectLanguage(_ language: AppLanguage) {
        LocalizationManager.shared.setLanguage(language)
    }
}
