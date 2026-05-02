//
//  SettingsViewProtocol.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 02/05/2026.
//


protocol SettingsViewProtocol: AnyObject {
    func updateThemeSwitch(isDark: Bool)
    func updateLanguageLabel(_ language: AppLanguage)
}