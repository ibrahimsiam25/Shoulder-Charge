//
//  OnboardingViewController.swift
//  Shoulder-Charge
//
//  Created by siam on 30/04/2026.
//

import UIKit

class OnboardingViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    private var arrContainer = [UIViewController]()
    private var data: [OnboardingSlide] {
     
        return LocalizationManager.shared.currentLanguage == "ar" ? Constants.onboardingSlide.reversed() : Constants.onboardingSlide
    }

    private var currentIndex: Int {
        guard let currentVC = viewControllers?.first,
              let index = arrContainer.firstIndex(of: currentVC) else {
            return 0
        }
        return index
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        dataSource = self
        delegate = self

        buildSlides()

        if let firstVC = arrContainer.first {
            setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
        }
    }

    private func buildSlides() {
        for (index, slide) in data.enumerated() {
            let vc = UIViewController()
            vc.view.backgroundColor = .systemBackground

            let customView = CustomOnboardingView()
            customView.configure(model: slide, totalPages: data.count)
            customView.translatesAutoresizingMaskIntoConstraints = false
            customView.onContinueTapped = { [weak self] in
                self?.handleContinue(from: index)
            }
            customView.onSkipTapped = { [weak self] in
                self?.finishOnboarding()
            }
            customView.onPageChanged = { [weak self] targetIndex in
                self?.goToPage(index: targetIndex)
            }

            vc.view.addSubview(customView)

            NSLayoutConstraint.activate([
                customView.topAnchor.constraint(equalTo: vc.view.topAnchor),
                customView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor),
                customView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
                customView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor)
            ])

            arrContainer.append(vc)
        }
    }

    private func handleContinue(from index: Int) {
        let nextIndex = index + 1
        if nextIndex < arrContainer.count {
            goToPage(index: nextIndex)
        } else {
            finishOnboarding()
        }
    }

    private func goToPage(index: Int) {
        guard index >= 0, index < arrContainer.count else { return }
        let current = currentIndex
        guard index != current else { return }
        let direction: UIPageViewController.NavigationDirection = index > current ? .forward : .reverse
        setViewControllers([arrContainer[index]], direction: direction, animated: true, completion: nil)
    }

    private func finishOnboarding() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        UserDefaults.standard.set(true, forKey: Constants.userDefaultsIsFirstTimeUserKey)
        let storyboard = self.storyboard
        let mainNav = storyboard?.instantiateViewController(withIdentifier: "MainNavigationController")
        window.rootViewController = mainNav
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    

    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = arrContainer.firstIndex(of: viewController), currentIndex > 0 else {
            return nil
        }
        return arrContainer[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = arrContainer.firstIndex(of: viewController), currentIndex < (arrContainer.count - 1) else {
            return nil
        }
        return arrContainer[currentIndex + 1]
    }
}
