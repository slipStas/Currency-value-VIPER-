//
//  PageInteractor.swift
//  My news
//
//  Created by Stanislav Slipchenko on 13.10.2020.
//

import Foundation

protocol PageInteractorProtocol: class {
    
}

class PageInteractor: PageInteractorProtocol {
    
    weak var presenter: PagePresenterProtocol!
    
    required init(presenter: PagePresenterProtocol) {
        self.presenter = presenter
    }
    
    
}
