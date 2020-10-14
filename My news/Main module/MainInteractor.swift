//
//  MainInteractor.swift
//  My news
//
//  Created by Stanislav Slipchenko on 07.10.2020.
//

import UIKit

protocol MainInteractorProtocol: class {
    var news: News {get}
    func loadNews(with category: CategoriesOfRequest, completionHandler: @escaping() -> ())
    func loadImagesNews(completionHandler: @escaping() -> ())
    func openUrl(with urlString: String)
}

class MainInteractor: MainInteractorProtocol {
    
    weak var presenter: MainPresenterProtocol!
    let mainService: MainServerServiceProtocol = MainServerService()
    
    required init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
    var news: News {
        get {
            guard let news = mainService.news else {return News(status: "error", articles: [])}

            return news
        }
    }

    func loadNews(with category: CategoriesOfRequest, completionHandler: @escaping() -> ()) {
        self.mainService.loadNews(with: category) { 
            completionHandler()
        }
    }
    
    func loadImagesNews(completionHandler: @escaping () -> ()) {
        self.mainService.loadImagesNews {
            completionHandler()
        }
    }
    
    func openUrl(with urlString: String) {
        mainService.openUrl(with: urlString)
    }
}
