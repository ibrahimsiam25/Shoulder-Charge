//
//  SettingsPresenter.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 28/04/2026.
//

import Foundation

class SettingsPresenter : SettingsPresenterProtocol{

    weak var view: SettingsViewProtocol?
    
    func attachView(_ view: SettingsViewProtocol){
        self.view = view
    }

    func viewDidLoad() {
        view?.updateThemeSwitch(isDark: isDarkTheme())
        view?.updateLanguageLabel(currentAppLanguage())
    }

    func isDarkTheme() -> Bool {
        ThemeManager.shared.currentTheme == .dark
    }

    func currentAppLanguage() -> AppLanguage {
        LocalizationManager.shared.currentAppLanguage
    }

    func userDidToggleTheme(isDark: Bool) {
        ThemeManager.shared.currentTheme = isDark ? .dark : .light
    }

    func userDidSelectLanguage(_ language: AppLanguage) {
        LocalizationManager.shared.setLanguage(language)
        view?.updateLanguageLabel(language)
    }
}
