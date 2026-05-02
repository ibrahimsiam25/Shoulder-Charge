//
//  SettingsPresenterProtocol.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 02/05/2026.
//
protocol SettingsPresenterProtocol {
    func attachView(_ view: SettingsViewProtocol)
    func viewDidLoad()
    func userDidToggleTheme(isDark: Bool)
    func userDidSelectLanguage(_ language: AppLanguage)
}

