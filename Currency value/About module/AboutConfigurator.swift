//
//  AboutConfigurator.swift
//  Currency value
//
//  Created by Stanislav Slipchenko on 07.10.2020.
//

import Foundation

protocol AboutConfiguratorProtocol: class {
    func configure(with controller: AboutViewController)
}

class AboutConfigurator: AboutConfiguratorProtocol {
    
    func configure(with controller: AboutViewController) {
        let presenter = AboutPresenter(view: controller)
        let interactor = AboutInteractor(presenter: presenter)
        let router = AboutRouter(viewController: controller)
        
        controller.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
