//
//  AbouRouter.swift
//  My news
//
//  Created by Stanislav Slipchenko on 07.10.2020.
//

import Foundation

protocol AboutRouterProtocol: class {
    
    func closeCurrentViewController()
}

class AboutRouter: AboutRouterProtocol {
    
    weak var viewController: AboutViewController!
    
    init(viewController: AboutViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController() {
        viewController.dismiss(animated: true, completion: nil)
    }
}
