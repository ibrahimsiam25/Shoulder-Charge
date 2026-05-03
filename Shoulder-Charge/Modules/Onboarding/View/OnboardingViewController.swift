//
//  OnboardingViewController.swift
//  Shoulder-Charge
//
//  Created by siam on 30/04/2026.
//

import UIKit
protocol OnboardingViewProtocol: AnyObject {
    func goToPage(index: Int)
}

class OnboardingViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, OnboardingViewProtocol {
    var router: OnboardingRouterProtocol = OnboardingRouter()
    var presenter: OnboardingPresenterProtocol!
    private var arrContainer = [UIViewController]()

    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.pageIndicatorTintColor = UIColor(named: "Text Sec")
        pc.currentPageIndicatorTintColor = UIColor(named: "Primary")
        pc.isUserInteractionEnabled = true
        return pc
    }()

    private var currentIndex: Int {
        guard let currentVC = viewControllers?.first,
              let index = arrContainer.firstIndex(of: currentVC) else {
            return 0
        }
        return index
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if presenter == nil {
            presenter = OnboardingPresenter(view: self, router: router)
        }
        
        view.backgroundColor = .systemBackground
        dataSource = self
        delegate = self

        buildSlides()

        if let firstVC = arrContainer.first {
            setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
        }
        
        setupPageControl()
        presenter.viewDidLoad()
    }

    private func setupPageControl() {
        view.addSubview(pageControl)
        pageControl.numberOfPages = presenter.slidesCount
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(handlePageControlChanged(_:)), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
        
        updatePageIndicators(currentPage: 0)
    }

    @objc private func handlePageControlChanged(_ sender: UIPageControl) {
        goToPage(index: sender.currentPage)
    }

    private func buildSlides() {
        for index in 0..<presenter.slidesCount {
            let slide = presenter.getSlide(at: index)
            let vc = UIViewController()
            vc.view.backgroundColor = .systemBackground

            let customView = CustomOnboardingView()
            customView.configure(model: slide, totalPages: presenter.slidesCount)
            customView.translatesAutoresizingMaskIntoConstraints = false
            customView.onContinueTapped = { [weak self] in
                self?.presenter.didTapContinue(from: index)
            }
            customView.onSkipTapped = { [weak self] in
                self?.presenter.didTapSkip()
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

    func goToPage(index: Int) {
        guard index >= 0, index < arrContainer.count else { return }
        let current = currentIndex
        guard index != current else { return }
        let direction: UIPageViewController.NavigationDirection = index > current ? .forward : .reverse
        setViewControllers([arrContainer[index]], direction: direction, animated: true) { [weak self] finished in
            if finished {
                self?.pageControl.currentPage = index
                self?.updatePageIndicators(currentPage: index)
            }
        }
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



    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            let index = currentIndex
            pageControl.currentPage = index
            updatePageIndicators(currentPage: index)
        }
    }



    private func updatePageIndicators(currentPage: Int) {
        guard pageControl.numberOfPages > 0 else { return }
        let inactiveColor = pageControl.pageIndicatorTintColor ?? .lightGray
        let activeColor = pageControl.currentPageIndicatorTintColor ?? .white
        let inactiveImage = makeDotImage(size: CGSize(width: 8, height: 8), color: inactiveColor)
        let activeImage = makeDotImage(size: CGSize(width: 32, height: 8), color: activeColor)
        
        for index in 0..<pageControl.numberOfPages {
            pageControl.setIndicatorImage(inactiveImage, forPage: index)
        }
        if currentPage < pageControl.numberOfPages {
            pageControl.setIndicatorImage(activeImage, forPage: currentPage)
        }
    }

    private func makeDotImage(size: CGSize, color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let rect = CGRect(origin: .zero, size: size)
            context.cgContext.setFillColor(color.cgColor)
            let radius = min(size.width, size.height) / 2
            let path = UIBezierPath(roundedRect: rect, cornerRadius: radius)
            path.fill()
        }.withRenderingMode(.alwaysOriginal)
    }
}
