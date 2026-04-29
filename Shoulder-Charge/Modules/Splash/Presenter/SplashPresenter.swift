//
//  SplashPresenter.swift
//  Shoulder-Charge
//
//  Created by siam on 29/04/2026.
//

import Foundation

protocol SplashPresenterProtocol: AnyObject {
    func startAnimation()
}


final class SplashPresenter: SplashPresenterProtocol {

    weak var view: SplashViewProtocol?

    init(view: SplashViewProtocol) {
        self.view = view
    }

    func startAnimation() {
      
        view?.animateLogoParts()

      
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) { [weak self] in
            self?.view?.showCenterLogo()
        }

  
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) { [weak self] in
            self?.view?.showAppTitle()
        }

     
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) { [weak self] in
            self?.view?.navigateToMain()
        }
    }
}
