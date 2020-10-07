//
//  MainConfigurator.swift
//  Currency value
//
//  Created by Stanislav Slipchenko on 07.10.2020.
//

import Foundation

protocol MainConfiguratorProtocol: class {
    func configure(with controller: MainViewController)
}

class MainConfigurator: MainConfiguratorProtocol {
    func configure(with controller: MainViewController) {
        let presenter = MainPresenter(view: controller)
        let interactor = MainInteractor()
        let router = MainRouter(viewController: controller)
        
        controller.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
