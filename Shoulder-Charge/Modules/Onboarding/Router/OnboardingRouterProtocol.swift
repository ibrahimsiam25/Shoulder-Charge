//
//  OnboardingRouterProtocol.swift
//  Shoulder-Charge
//
//  Created by antigravity on 03/05/2026.
//

import UIKit

protocol OnboardingRouterProtocol {
    static func build() -> UIViewController
    func navigateToMainApp(from view: OnboardingViewProtocol)
}
