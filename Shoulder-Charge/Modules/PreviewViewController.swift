//
//  PreviewViewController.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 28/04/2026.
//

import UIKit

class PreviewViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshText()
    }

    // MARK: - Text Refresh

    private func refreshText() {
        title               = L10n.Settings.title
        label1.text         = L10n.Settings.title       // "Settings" / "الإعدادات"
        label2.text         = L10n.Settings.theme       // "Theme"    / "المظهر"
        label3.text         = L10n.Settings.language    // "Language" / "اللغة"
    }

    // MARK: - Actions

    /// Cycles through System → Light → Dark → System
    @IBAction func toggleThemeTapped(_ sender: Any) {
        let next: AppTheme
        switch ThemeManager.shared.currentTheme {
        case .system: next = .light
        case .light:  next = .dark
        case .dark:   next = .system
        }
        ThemeManager.shared.currentTheme = next
    }

    /// Switches UI language to Arabic (triggers root-VC crossfade reload)
    @IBAction func switchToArabicTapped(_ sender: Any) {
        LocalizationManager.shared.setLanguage(.ar)
    }

    /// Switches UI language to English (triggers root-VC crossfade reload)
    @IBAction func switchToEnglishTapped(_ sender: Any) {
        LocalizationManager.shared.setLanguage(.en)
    }
}
