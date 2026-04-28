//
//  ViewController.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 28/04/2026.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {
    func updateThemeSelection(theme: AppTheme)
    func updateLanguageSelection(language: AppLanguage)
}

class ViewController: UIViewController, SettingsViewProtocol {
    var presenter: SettingsPresenter!

    @IBOutlet weak var themeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var languageSegmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SettingsPresenter()
        presenter.view = self
        presenter.viewDidLoad()
    }

    @IBAction func themeSegmentChanged(_ sender: UISegmentedControl) {
        let theme = AppTheme.allCases[sender.selectedSegmentIndex]
        presenter.userDidSelectTheme(theme)
    }

    @IBAction func languageSegmentChanged(_ sender: UISegmentedControl) {
        let language = AppLanguage.allCases[sender.selectedSegmentIndex]
        presenter.userDidSelectLanguage(language)
    }

    func updateThemeSelection(theme: AppTheme) {
        guard let index = AppTheme.allCases.firstIndex(of: theme) else { return }
        themeSegmentedControl.selectedSegmentIndex = index
    }

    func updateLanguageSelection(language: AppLanguage) {
        guard let index = AppLanguage.allCases.firstIndex(of: language) else { return }
        languageSegmentedControl.selectedSegmentIndex = index
    }
}
