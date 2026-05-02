//
//  AppearanceCell.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 02/05/2026.
//

import UIKit

class AppearanceCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var appearanceSwitch: UISwitch!

    private var presenter: SettingsPresenterProtocol?

    func configure(with presenter: SettingsPresenterProtocol) {
        self.presenter = presenter
        titleLabel.text = L10n.Settings.appearance
        appearanceSwitch.isOn = presenter.isDarkTheme()
        appearanceSwitch.removeTarget(nil, action: nil, for: .valueChanged)
        appearanceSwitch.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
    }

    @objc private func switchToggled(_ sender: UISwitch) {
        presenter?.userDidToggleTheme(isDark: sender.isOn)
    }
}
