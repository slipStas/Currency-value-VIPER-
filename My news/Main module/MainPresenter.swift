//
//  MainPresenter.swift
//  My news
//
//  Created by Stanislav Slipchenko on 07.10.2020.
//

import Foundation

protocol MainPresenterProtocol: class {
    
    var router: MainRouterProtocol! {get set}
    func configureView(with category: CategoriesOfRequest, completionHandler: @escaping() -> ())
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
    
    func configureView(with category: CategoriesOfRequest, completionHandler: @escaping() -> ()) {
        self.interactor.loadNews(with: view.categoryOfRequest, completionHandler: {
            self.view.show(news: self.interactor.news)
            self.view.reloadData()
            completionHandler()
            self.interactor.loadImagesNews(completionHandler: {
                self.view.reloadData()
            })
        })
    }
    
    func goToSite(with urlString: String) {
        
        interactor.openUrl(with: urlString)
    }
    
}

