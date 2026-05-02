//
//  SettingsViewController.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 02/05/2026.
//

import UIKit

class SettingsViewController: UIViewController {

    var presenter: SettingsPresenterProtocol!

    @IBOutlet weak var settingsTableView: UITableView!

    private weak var appearanceSwitch: UISwitch?
    private weak var languageDetailLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SettingsPresenter()
        presenter.attachView(self)
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewDidLoad()
    }

    private func setupTableView() {
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.isScrollEnabled = false
    }
}

// MARK: - SettingsViewProtocol

extension SettingsViewController: SettingsViewProtocol {

    func updateThemeSwitch(isDark: Bool) {
        appearanceSwitch?.isOn = isDark
    }

    func updateLanguageLabel(_ language: AppLanguage) {
        languageDetailLabel?.text = language.displayName
    }
}

// MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int { 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 2 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppearanceCell", for: indexPath)

            cell.contentView.subviews.compactMap { $0 as? UILabel }.first?.text = L10n.Settings.appearance

            // Find the switch wherever it lives (accessoryView or contentView).
            let sw = (cell.accessoryView as? UISwitch)
                ?? cell.contentView.subviews.compactMap { $0 as? UISwitch }.first
            if let sw {
                sw.removeTarget(nil, action: nil, for: .valueChanged)
                sw.addTarget(self, action: #selector(appearanceSwitchToggled(_:)), for: .valueChanged)
                sw.isOn = ThemeManager.shared.currentTheme == .dark
                appearanceSwitch = sw
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath)
            let labels = cell.contentView.subviews.compactMap { $0 as? UILabel }
            labels.first?.text = L10n.Settings.language
            labels.dropFirst().first?.text = LocalizationManager.shared.currentAppLanguage.displayName
            languageDetailLabel = labels.dropFirst().first
            let isRTL = LocalizationManager.shared.currentLanguage == "ar"
            let dir: UISemanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
            cell.semanticContentAttribute = dir
            cell.contentView.semanticContentAttribute = dir
            labels.forEach {
                $0.semanticContentAttribute = dir
                $0.textAlignment = .natural
            }
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.row == 1 else { return }
        showLanguagePicker()
    }
}

// MARK: - Actions

extension SettingsViewController {

    @objc private func appearanceSwitchToggled(_ sender: UISwitch) {
        presenter.userDidToggleTheme(isDark: sender.isOn)
    }
}

// MARK: - Language Picker

extension SettingsViewController {

    private func showLanguagePicker() {
        let alert = UIAlertController(
            title: L10n.Settings.language,
            message: nil,
            preferredStyle: .actionSheet
        )
        for language in AppLanguage.allCases {
            alert.addAction(UIAlertAction(title: language.displayName, style: .default) { [weak self] _ in
                self?.presenter.userDidSelectLanguage(language)
            })
        }
        alert.addAction(UIAlertAction(title: L10n.Common.cancel, style: .cancel))
        present(alert, animated: true)
    }
}
