//
//  MainInteractor.swift
//  My news
//
//  Created by Stanislav Slipchenko on 07.10.2020.
//

import Foundation

protocol MainInteractorProtocol: class {
    var news: News {get}
    var newsCount: Int {get}
    func loadNews()
}

class MainInteractor: MainInteractorProtocol {
    
    weak var presenter: MainPresenterProtocol!
    let mainService: MainServerServiceProtocol = MainServerService()
    
    required init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
    var news: News {
        get {
            guard let news = mainService.news else {return News(status: "error", totalResults: 0, articles: [])}
            return news
        }
    }
    var newsCount: Int {
        get {
            return news.totalResults
        }
    }
    
    func loadNews() {
        self.mainService.loadNews()
    }
}
