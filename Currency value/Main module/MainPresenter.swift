//
//  MainPresenter.swift
//  Currency value
//
//  Created by Stanislav Slipchenko on 07.10.2020.
//

import Foundation

protocol MainPresenterProtocol: class {
    
    var router: MainRouterProtocol! {get set}
    func configureView()
    func infoButtonClicked()
}

class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol!
    var interactor: MainInteractorProtocol!
    var router: MainRouterProtocol!
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
    
    func infoButtonClicked() {
        router.presentAboutController()
    }
    
    func configureView() {
        
    }
    
    
}
