//
//  AboutInteractor.swift
//  My news
//
//  Created by Stanislav Slipchenko on 07.10.2020.
//

import Foundation

protocol AboutInteractorProtocol: class {
    var urlRatesSource: String {get}
    var descriptionTitle: String {get}
    var thanksForTitle: String {get}
    func openUrl(with urlString: String)
}

class AboutInteractor: AboutInteractorProtocol {
    
    weak var presenter: AboutPresenterProtocol!
    let serverService: AboutServerServiceProtocol = AboutServerService()
    let titleLabelsModel: TitleLabelsModelProtocol = TitleLabelModel()
    
    required init(presenter: AboutPresenterProtocol) {
        self.presenter = presenter
    }
    
    var urlRatesSource: String {
        get {
            return serverService.urlRatesSource
        }
    }
    var descriptionTitle: String {
        get {
            return titleLabelsModel.descriptionTitle
        }
    }
    
    var thanksForTitle: String {
        get {
            return titleLabelsModel.thanksTitle
        }
    }
    
    func openUrl(with urlString: String) {
        serverService.openUrl(with: urlString)
    }
}
