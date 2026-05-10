//
//  HomePresenter.swift
//  Shoulder-Charge
//
//  Created by siam on 03/05/2026.
//

import Foundation

protocol HomePresenterProtocol {
    var sports: [SportType] { get }
    func viewDidLoad()
    func didSelectSport(at index: Int)
}

class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    private let router: HomeRouterProtocol
    
    let sports: [SportType] = [.football, .basketball, .tennis, .cricket]
    
    init(view: HomeViewProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        // Any initial setup
    }
    
    func didSelectSport(at index: Int) {
        guard index >= 0 && index < sports.count else { return }
        let selectedSport = sports[index]
        if let view = view {
            router.navigateToLeagues(with: selectedSport, from: view)
        }
    }
}
