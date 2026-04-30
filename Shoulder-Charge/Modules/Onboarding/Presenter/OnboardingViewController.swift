//
//  OnboardingViewController.swift
//  Shoulder-Charge
//
//  Created by siam on 30/04/2026.
//

import UIKit

class OnboardingViewController: UIPageViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    private var arrContainer = [UIViewController]()
    var data = [
        OnboardingSlide(
            titleWhite: "Feel The",
            titlePrimary: "Charge",
            description: "Unleash your power like CR7",
            image: "onBoarding_1",
            currentPage: 0),
        OnboardingSlide(
            titleWhite: "Charge The",
            titlePrimary: "Court",
            description: "Own the paint. Feel the impact.",
            image: "onBoarding_2",
            currentPage: 1),
        OnboardingSlide(
            titleWhite: "Charge The",
            titlePrimary: "Court",
            description: "Dominate every point with power",
            image: "onBoarding_3",
            currentPage: 2)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        print("Ddddddddsds")
        self.dataSource = self
        self.delegate = self
        
        // Setup ViewControllers for each slide
        for (index, slide) in data.enumerated() {
            let vc = UIViewController()
            vc.view.backgroundColor = .systemBackground
            
            let customView = CustomOnboardingView()
            customView.configure(model: slide, totalPages: data.count)
            customView.onContinueTapped = { [weak self] in
                self?.handleContinue(from: index)
            }
            customView.onSkipTapped = { [weak self] in
                self?.handleSkip()
            }
            customView.onPageChanged = { [weak self] targetIndex in
                self?.showPage(at: targetIndex, from: index)
            }
            customView.translatesAutoresizingMaskIntoConstraints = false
            
            vc.view.addSubview(customView)
            
            NSLayoutConstraint.activate([
                customView.topAnchor.constraint(equalTo: vc.view.topAnchor),
                customView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor),
                customView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
                customView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor)
            ])
            
            arrContainer.append(vc)
        }
        
        // Set the initial ViewController
        if let firstVC = arrContainer.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }

    private func showPage(at targetIndex: Int, from currentIndex: Int) {
        guard targetIndex >= 0, targetIndex < arrContainer.count else { return }
        guard targetIndex != currentIndex else { return }
        let direction: UIPageViewController.NavigationDirection = targetIndex > currentIndex ? .forward : .reverse
        setViewControllers([arrContainer[targetIndex]], direction: direction, animated: true, completion: nil)
    }

    private func handleContinue(from currentIndex: Int) {
        let nextIndex = currentIndex + 1
        guard nextIndex < arrContainer.count else { return }
        setViewControllers([arrContainer[nextIndex]], direction: .forward, animated: true, completion: nil)
    }

    private func handleSkip() {
        let lastIndex = arrContainer.count - 1
        guard lastIndex >= 0 else { return }
        setViewControllers([arrContainer[lastIndex]], direction: .forward, animated: true, completion: nil)
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
