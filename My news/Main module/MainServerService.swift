//
//  MainServerService.swift
//  My news
//
//  Created by Stanislav Slipchenko on 09.10.2020.
//

import Foundation

protocol MainServerServiceProtocol: class {
    var news: NewsModel? {get set}
    func loadNews()
}

class MainServerService: MainServerServiceProtocol {
    
    let apiKey = "28d2250865c9496296dd09e61ef40ddc"
    var news: NewsModel? 
    
    func loadNews() {
        let configurator = URLSessionConfiguration.default
        let session = URLSession(configuration: configurator)
        var urlConstructor = URLComponents()
        
        urlConstructor.scheme = "https"
        urlConstructor.host = "newsapi.org"
        urlConstructor.path = "/v2/top-headlines"
        urlConstructor.queryItems = [
            URLQueryItem(name: "country", value: "ru"),
            URLQueryItem(name: "apiKey", value: "28d2250865c9496296dd09e61ef40ddc")]
        
        guard let url = urlConstructor.url else {return}
        
        print(url)
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            
            let news = try? JSONDecoder().decode(NewsModel.self, from: data)
            self.news = news
        }
        task.resume()
    }
}
