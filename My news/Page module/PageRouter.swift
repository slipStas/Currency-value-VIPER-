//
//  PageRouter.swift
//  My news
//
//  Created by Stanislav Slipchenko on 13.10.2020.
//

import Foundation

protocol PageRouterProtocol: class {
    
    func presentAboutController()
}

class PageRouter: PageRouterProtocol {
    
    weak var viewController: PageViewController!
    
    required init(viewController: PageViewController) {
        self.viewController = viewController
    }
    
    func presentAboutController() {
        
        let aboutVC = AboutViewController()
        viewController.present(aboutVC, animated: true, completion: nil)
    }
}
