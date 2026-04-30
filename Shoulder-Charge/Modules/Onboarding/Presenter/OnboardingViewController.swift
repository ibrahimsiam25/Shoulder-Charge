//
//  OnboardingViewController.swift
//  Shoulder-Charge
//
//  Created by siam on 30/04/2026.
//

import UIKit

class OnboardingViewController: UIPageViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource {
var arrContainer = [UIViewController]()
    var data = [
        OnboardingSlide(
            titleWhite: "Feel The",
            titlePrimary: "Charge",
            description: "Unleash your power like CR7",
            image: "onBoarding_1",
            currentPage: 1),
        OnboardingSlide(
            titleWhite: "Charge The",
            titlePrimary: "Court",
            description: "Own the paint. Feel the impact.",
            image: "onBoarding_2",
            currentPage: 2),
        OnboardingSlide(
            titleWhite: "Charge The",
            titlePrimary: "Court",
            description: "Dominate every point with power",
            image: "onBoarding_3",
            currentPage: 3)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        print("Ddddddddsds")
        self.dataSource = self
        self.delegate = self
        
        // Setup ViewControllers for each slide
        for slide in data {
            let vc = UIViewController()
            vc.view.backgroundColor = .systemBackground
            
            let customView = CustomOnboardingView()
            customView.configure(model: slide, totalPages: data.count)
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
    
    // MARK: - UIPageViewControllerDataSource
    
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
