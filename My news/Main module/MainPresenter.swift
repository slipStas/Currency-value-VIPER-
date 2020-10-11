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
    func goToSite(with urlString: String)
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
        self.interactor.loadNews()                                                  // улетает запрос на сервер
        sleep(2)                                    // жду 2 секунды для того, чтобы успели вернуться данные с сервера
        self.view.show(news: self.interactor.news, images: self.interactor.images)  // обновляются переменные во вью
        self.view.reloadData()                                                      // перезагружается таблица
    }
    
    func goToSite(with urlString: String) {
        
        interactor.openUrl(with: urlString)
    }
    
}

