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
        settingsTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    }

    func updateLanguageLabel(_ language: AppLanguage) {
        settingsTableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .none)
    }
}

// MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int { 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 2 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppearanceCell", for: indexPath) as! AppearanceCell
            cell.configure(with: presenter)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as! LanguageCell
            cell.configure(with: presenter)
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
