//
//  MainRouter.swift
//  My news
//
//  Created by Stanislav Slipchenko on 07.10.2020.
//

import UIKit

protocol MainRouterProtocol: class {
    
}

class MainRouter: MainRouterProtocol {
    
    weak var viewController: MainViewController!
    
    required init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
}
