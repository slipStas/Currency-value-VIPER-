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
    func configureViewWith(searchText: String, completionHandler: @escaping() -> ())
    func goToSite(with urlString: String)
}

class MainPresenter: MainPresenterProtocol {
   
    
    weak var view: MainViewProtocol!
    var interactor: MainInteractorProtocol!
    var router: MainRouterProtocol!
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
    func configureViewWith(searchText: String, completionHandler: @escaping() -> ()) {
        interactor.loadEverythingNews(with: searchText, completionHandler: {
            self.view.show(news: self.interactor.news)
            self.view.searchText = searchText
            self.view.reloadData()
            completionHandler()
            self.interactor.loadImagesNews(completionHandler: {
                self.view.reloadData()
            })
        })
    }
    
    func configureView(with category: CategoriesOfRequest, completionHandler: @escaping() -> ()) {
        
        guard let category = view.categoryOfRequest else {return}
        self.interactor.loadHeadlinerNews(with: category, completionHandler: {
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

