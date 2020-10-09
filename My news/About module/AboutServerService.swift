//
//  AboutServerService.swift
//  My news
//
//  Created by Stanislav Slipchenko on 07.10.2020.
//

import UIKit

protocol AboutServerServiceProtocol: class {
    var urlRatesSource: String {get}
    func openUrl(with urlString: String?)
}

class AboutServerService: AboutServerServiceProtocol {
    var urlRatesSource: String {
        return "https://newsapi.org/"
    }
    
    func openUrl(with urlString: String?) {
        guard let url = URL(string: urlString!) else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
