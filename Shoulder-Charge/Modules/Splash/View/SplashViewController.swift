//
//  SplashViewController.swift
//  Shoulder-Charge
//
//  Created by siam on 29/04/2026.
//

import UIKit
import AVFoundation

protocol SplashViewProtocol: AnyObject {
    func animateLogoParts()
    func showCenterLogo()
    func showAppTitle()
}

class SplashViewController: UIViewController {

    @IBOutlet private weak var leftLogoImageView: UIImageView!
    @IBOutlet private weak var rightLogoImageView: UIImageView!
    @IBOutlet private weak var centerLogoImageView: UIImageView!
    @IBOutlet private weak var titleImageView: UIImageView!

    private var audioPlayer: AVAudioPlayer?
    private var presenter: SplashPresenterProtocol!
    private var didSetInitialTransforms = false

    override func viewDidLoad() {
        super.viewDidLoad()
        applyLeftToRightRecursively(on: view)
        setupUI()
        presenter = SplashPresenter(view: self)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setInitialLogoTransformsIfNeeded()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.startAnimation()
        scheduleMainTransition()
    }

    private func setupUI() {
        view.backgroundColor = .black
        leftLogoImageView.alpha = 0
        rightLogoImageView.alpha = 0
        centerLogoImageView.alpha = 0
        centerLogoImageView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        titleImageView.alpha = 0
    }

    private func applyLeftToRightRecursively(on rootView: UIView) {
        rootView.semanticContentAttribute = .forceLeftToRight
        rootView.subviews.forEach { subview in
            applyLeftToRightRecursively(on: subview)
        }
    }

    private func setInitialLogoTransformsIfNeeded() {
        guard !didSetInitialTransforms else { return }
        didSetInitialTransforms = true

        let offscreenX = view.bounds.width
        leftLogoImageView?.transform = CGAffineTransform(translationX: -offscreenX, y: 0)
        rightLogoImageView?.transform = CGAffineTransform(translationX: offscreenX, y: 0)
    }

    private func scheduleMainTransition() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) { [weak self] in
            self?.transitionToMain()
        }
    }

   
    private func playCollisionSound() {
        guard let url = Bundle.main.url(forResource: "splash_sound",
                                        withExtension: "wav") else {
            print(" Sound file not found")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print(" Audio error: \(error)")
        }
    }

   
    private func transitionToMain() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        
        let isFirstTime = UserDefaults.standard.bool(forKey: Constants.userDefaultsIsFirstTimeUserKey)
        
        if isFirstTime {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainNav = storyboard.instantiateViewController(withIdentifier: "MainNavigationController")
            window.rootViewController = mainNav
            window.makeKeyAndVisible()
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let onboardingVC = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController")
            window.rootViewController = onboardingVC
        }
        
        UIView.transition(with: window,
                          duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)}
}



extension SplashViewController: SplashViewProtocol {

    func animateLogoParts() {
        playCollisionSound()

        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.8,
                       options: .curveEaseIn,
                       animations: {
            self.leftLogoImageView?.transform = .identity
            self.rightLogoImageView?.transform = .identity
            self.leftLogoImageView?.alpha = 1
            self.rightLogoImageView?.alpha = 1
        }, completion: nil)

        let centerLogoDelay: TimeInterval = 0.2
        DispatchQueue.main.asyncAfter(deadline: .now() + centerLogoDelay) {
            self.showCenterLogo()
        }
    }

    func showCenterLogo() {

        UIView.animate(withDuration: 0.4,
                       delay: 0.05,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 1.2,
                       options: []) {
            self.centerLogoImageView?.alpha = 1
            self.centerLogoImageView?.transform = .identity
        }
    }

    func showAppTitle() {
        titleImageView?.transform = CGAffineTransform(translationX: 0, y: 60)
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5,
                       options: []) {
            self.titleImageView?.alpha = 1
            self.titleImageView?.transform = .identity
        }
    }
}
