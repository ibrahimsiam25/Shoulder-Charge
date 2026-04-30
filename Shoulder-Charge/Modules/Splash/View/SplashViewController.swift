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
    func navigateToMain()
}

class SplashViewController: UIViewController {


    private let leftLogoImageView   = UIImageView()
    private let rightLogoImageView  = UIImageView()
    private let centerLogoImageView = UIImageView()
    private let titleImageView      = UIImageView()


    private var audioPlayer: AVAudioPlayer?


    private var presenter: SplashPresenterProtocol!

  
    private var centerLogoSize: CGFloat {
        view.bounds.width * 0.8
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter = SplashPresenter(view: self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.startAnimation()
    }


    private func setupUI() {
        view.backgroundColor = .black

  
        leftLogoImageView.image       = UIImage(named: "SplashLeft")
        leftLogoImageView.contentMode = .scaleAspectFit
        leftLogoImageView.frame       = leftLogoFrame(offscreen: true)
        view.addSubview(leftLogoImageView)


        rightLogoImageView.image       = UIImage(named: "SplashRight")
        rightLogoImageView.contentMode = .scaleAspectFit
        rightLogoImageView.frame       = rightLogoFrame(offscreen: true)
        view.addSubview(rightLogoImageView)

    centerLogoImageView.image       = UIImage(named: "SplashCenter")
        centerLogoImageView.contentMode = .scaleAspectFit
        centerLogoImageView.alpha       = 0
        centerLogoImageView.frame       = centerLogoFrame()
        centerLogoImageView.transform   = CGAffineTransform(scaleX: 0.01, y: 0.01)
        view.addSubview(centerLogoImageView)


        titleImageView.image       = UIImage(named: "SplashBottom")
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.alpha       = 0
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleImageView)
        NSLayoutConstraint.activate([
            titleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            titleImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            titleImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }


    private func centerPoint() -> CGPoint {
        CGPoint(x: view.bounds.midX, y: view.bounds.height * 0.28)
    }

    private func leftLogoFrame(offscreen: Bool) -> CGRect {
        let center = centerPoint()
        let size   = centerLogoSize
        let width  = size / 2
        let x      = offscreen ? -width : center.x - width
        return CGRect(x: x, y: center.y - size / 2, width: width, height: size)
    }

    private func rightLogoFrame(offscreen: Bool) -> CGRect {
        let center = centerPoint()
        let size   = centerLogoSize
        let width  = size / 2
        let x      = offscreen ? view.bounds.width : center.x
        return CGRect(x: x, y: center.y - size / 2, width: width, height: size)
    }
    private func centerLogoFrame() -> CGRect {
        let center = centerPoint()
        let size   = centerLogoSize
        return CGRect(x: center.x - size / 2,
                      y: center.y - size / 2,
                      width: size,
                      height: size)
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
}


extension SplashViewController: SplashViewProtocol {

    func animateLogoParts() {
        playCollisionSound()

      let centerLogoDelay: TimeInterval = 0.2
        
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.8,
                       options: .curveEaseIn,
                       animations: {
            self.leftLogoImageView.frame  = self.leftLogoFrame(offscreen: false)
            self.rightLogoImageView.frame = self.rightLogoFrame(offscreen: false)
        }, completion: nil)

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
            self.centerLogoImageView.alpha     = 1
            self.centerLogoImageView.transform = .identity        }
    }

    func showAppTitle() {
        titleImageView.transform = CGAffineTransform(translationX: 0, y: 60)
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5,
                       options: []) {
            self.titleImageView.alpha     = 1
            self.titleImageView.transform = .identity
        }
    }

    func navigateToMain() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        
        let initialVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        window.rootViewController = initialVC
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
