//
//  MainServerService.swift
//  My news
//
//  Created by Stanislav Slipchenko on 09.10.2020.
//

import UIKit

protocol MainServerServiceProtocol: class {
    var news: News? {get set}
    func loadHeadlineNews(with category: CategoriesOfRequest, completionHandler: @escaping() -> ())
    func loadEverythingNews(with searching: String, completionHandler: @escaping() -> ())
    func loadImagesNews(completionHandler: @escaping() -> ())
    func openUrl(with urlString: String)
}

class MainServerService: MainServerServiceProtocol {
    
    private let apiKey = "28d2250865c9496296dd09e61ef40ddc"
    var news: News?
    
    func loadEverythingNews(with searching: String, completionHandler: @escaping () -> ()) {
        DispatchQueue.main.async {
            let configurator = URLSessionConfiguration.default
            let session = URLSession(configuration: configurator)
            var urlConstructor = URLComponents()
            
            urlConstructor.scheme = "https"
            urlConstructor.host = "newsapi.org"
            urlConstructor.path = "/v2/everything"
            urlConstructor.queryItems = [
                URLQueryItem(name: "q", value: "searching"),
                URLQueryItem(name: "apiKey", value: self.apiKey),
                URLQueryItem(name: "pageSize", value: "35")]
            
            guard let url = urlConstructor.url else {return}
            
            session.dataTask(with: url) { (data, response, error) in
                guard let data = data else {return}
                
                let news = try? JSONDecoder().decode(News.self, from: data)
                
                self.news = news
                completionHandler()
            }.resume()
        }
    }
    
    func loadHeadlineNews(with category: CategoriesOfRequest, completionHandler: @escaping() -> ()) {
        DispatchQueue.main.async {
            let configurator = URLSessionConfiguration.default
            let session = URLSession(configuration: configurator)
            var urlConstructor = URLComponents()
            
            urlConstructor.scheme = "https"
            urlConstructor.host = "newsapi.org"
            urlConstructor.path = "/v2/top-headlines"
            urlConstructor.queryItems = [
                URLQueryItem(name: "country", value: "ru"),
                URLQueryItem(name: "category", value: category.rawValue),
                URLQueryItem(name: "apiKey", value: self.apiKey),
                URLQueryItem(name: "pageSize", value: "35")]
            
            guard let url = urlConstructor.url else {return}
            
            session.dataTask(with: url) { (data, response, error) in
                guard let data = data else {return}
                
                let news = try? JSONDecoder().decode(News.self, from: data)
                
                self.news = news
                completionHandler()
            }.resume()
        }
    }
    
    func loadImagesNews(completionHandler: @escaping() -> ()) {
        self.news?.articles.forEach({ (articles) in

            guard let urlString = articles.urlToImage else {return}
            
            let url = URL(string: urlString)
            guard let urlNotNil = url else {return}
            
            let data = try? Data(contentsOf: urlNotNil)
            guard let dataNotNil = data else {return}
            
            let image = UIImage(data: dataNotNil)
            
            articles.imageNews = image ?? UIImage(named: "loading")!
            completionHandler()
        })
    }
    
    func openUrl(with urlString: String) {
        guard let url = URL(string: urlString) else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
