//
//  MainInteractor.swift
//  My news
//
//  Created by Stanislav Slipchenko on 07.10.2020.
//

import Foundation

protocol MainInteractorProtocol: class {
    func loadNews()
}

class MainInteractor: MainInteractorProtocol {
    
    weak var presenter: MainPresenterProtocol!
    let mainService: MainServerServiceProtocol = MainServerService()
    
    required init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
    func loadNews() {
        mainService.loadNews()
    }
}
