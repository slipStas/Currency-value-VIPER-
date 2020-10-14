//
//  MainRouter.swift
//  My news
//
//  Created by Stanislav Slipchenko on 07.10.2020.
//

import UIKit

protocol MainRouterProtocol: class {
    
    func presentAboutController()
}

class MainRouter: MainRouterProtocol {
    
    weak var viewController: MainViewController!
    
    required init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
    func presentAboutController() {
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationVC = AboutViewController() //storyboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        viewController.present(navigationVC, animated: true, completion: nil)
    }
}
