//
//  PagePresenter.swift
//  My news
//
//  Created by Stanislav Slipchenko on 13.10.2020.
//

import Foundation

protocol PagePresenterProtocol: class {
    
    var router: PageRouterProtocol! {get set}
    func configureView(completionHandler: @escaping() -> ())
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
    
    func configureView(completionHandler: @escaping () -> ()) {
        
        let firstVC = MainViewController(categoryOfRequest: .general)
        let secondVC = MainViewController(categoryOfRequest: .business)
        let thirdVC = MainViewController(categoryOfRequest: .entertainment)
        let foursVC = MainViewController(categoryOfRequest: .health)
        let fivethVC = MainViewController(categoryOfRequest: .science)
        let sixthVC = MainViewController(categoryOfRequest: .sports)
        let seventhVC = MainViewController(categoryOfRequest: .technology)

        view.newsViewControllers.append(contentsOf: [firstVC, secondVC, thirdVC, foursVC, fivethVC, sixthVC, seventhVC])
        
        completionHandler()
    }
}
