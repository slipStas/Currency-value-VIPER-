//
//  MainPresenter.swift
//  My news
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
        DispatchQueue.main.async {
            self.interactor.loadNews()
            sleep(2)
            
            self.view.show(news: self.interactor.news, images: self.interactor.images)
            self.view.reloadData()
        }
    }
}

