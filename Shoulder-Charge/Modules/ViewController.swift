//
//  ViewController.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 28/04/2026.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {
    func updateThemeSelection(theme: AppTheme)
}

class ViewController: UIViewController, SettingsViewProtocol {
    var presenter: SettingsPresenter!

    @IBOutlet weak var themeSegmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SettingsPresenter()
        presenter.view = self
        presenter.viewDidLoad()
    }

    @IBAction func pushToNext(_ sender: Any) {}

    @IBAction func themeSegmentChanged(_ sender: UISegmentedControl) {
        let theme = AppTheme.allCases[sender.selectedSegmentIndex]
        presenter.userDidSelectTheme(theme)
    }

    func updateThemeSelection(theme: AppTheme) {
        guard let index = AppTheme.allCases.firstIndex(of: theme) else { return }
        themeSegmentedControl.selectedSegmentIndex = index
    }
}
