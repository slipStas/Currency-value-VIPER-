//
//  PagePresenter.swift
//  My news
//
//  Created by Stanislav Slipchenko on 13.10.2020.
//

import Foundation

protocol PagePresenterProtocol: class {
    
    var router: PageRouterProtocol! {get set}
    func configureViewWithHeadliners(completionHandler: @escaping() -> ())
    func configureViewWithEverything(searchTex: String?, completionHandler: @escaping() -> ())
    func infoButtonClicked()
}

class PagePresenter: PagePresenterProtocol {
   
    weak var view: PageViewController!
    var interactor: PageInteractorProtocol!
    var router: PageRouterProtocol!
    
    required init(view: PageViewController) {
        self.view = view
    }
    
    func infoButtonClicked() {
        router.presentAboutController()
    }
    
    func configureViewWithHeadliners(completionHandler: @escaping () -> ()) {
        
        let firstVC = MainViewController(categoryOfRequest: .general, searchText: nil)
        let secondVC = MainViewController(categoryOfRequest: .business, searchText: nil)
        let thirdVC = MainViewController(categoryOfRequest: .entertainment, searchText: nil)
        let foursVC = MainViewController(categoryOfRequest: .health, searchText: nil)
        let fivethVC = MainViewController(categoryOfRequest: .science, searchText: nil)
        let sixthVC = MainViewController(categoryOfRequest: .sports, searchText: nil)
        let seventhVC = MainViewController(categoryOfRequest: .technology, searchText: nil)

        view.newsViewControllers.append(contentsOf: [firstVC, secondVC, thirdVC, foursVC, fivethVC, sixthVC, seventhVC])
        
        completionHandler()
    }
    
    func configureViewWithEverything(searchTex: String?, completionHandler: @escaping () -> ()) {
        
        let searchVC = MainViewController(categoryOfRequest: nil, searchText: searchTex)
        view.newsViewControllers.insert(searchVC, at: 0)
        completionHandler()
    }
    
}
