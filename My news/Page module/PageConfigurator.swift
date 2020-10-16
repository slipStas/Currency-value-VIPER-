//
//  PageConfigurator.swift
//  My news
//
//  Created by Stanislav Slipchenko on 13.10.2020.
//

import Foundation

protocol PageConfiguratorProtocol: class {
    func configure(with controller: PageViewController)
}

class PageConfigurator: PageConfiguratorProtocol {
    
    func configure(with controller: PageViewController) {
        let presenter = PagePresenter(view: controller)
        let interactor = PageInteractor(presenter: presenter)
        let router = PageRouter(viewController: controller)
        
        controller.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        
    }
}
