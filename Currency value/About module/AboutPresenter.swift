//
//  AboutPresenter.swift
//  Currency value
//
//  Created by Stanislav Slipchenko on 07.10.2020.
//

import Foundation

protocol AboutPresenterProtocol: class {
    
    var router: AboutRouterProtocol! {get set}
    func configureView()
    func closeButtonClicked()
    func urlButtonClicked(with url: String?)
}

class AboutPresenter: AboutPresenterProtocol {
    
    weak var view: AboutViewProtocol!
    var  interactor: AboutInteractorProtocol!
    var router: AboutRouterProtocol!
    
    required init(view: AboutViewProtocol) {
        self.view = view
    }
    
    // MARK: - AboutPresenterProtocol methods
    func configureView() {
        view.setUrlButtonTitle(with: interactor.urlRatesSource)
        view.setDescriptionLabel(with: interactor.descriptionTitle)
        view.setThanksForLabel(with: interactor.thanksForTitle)
    }
    
    func closeButtonClicked() {
        router.closeCurrentViewController()
    }
    
    func urlButtonClicked(with urlString: String?) {
        guard let url = urlString else {return}
        
        interactor.openUrl(with: url)
    }
}
