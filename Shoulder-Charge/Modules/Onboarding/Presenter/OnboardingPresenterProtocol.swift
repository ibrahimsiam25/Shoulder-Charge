//
//  OnboardingPresenterProtocol.swift
//  Shoulder-Charge
//
//  Created by antigravity on 03/05/2026.
//

import Foundation


protocol OnboardingPresenterProtocol: AnyObject {
    var  slidesCount: Int { get }
    func getSlide(at index: Int) -> OnboardingSlide
    func viewDidLoad()
    func didTapContinue(from index: Int)
    func didTapSkip()
}
