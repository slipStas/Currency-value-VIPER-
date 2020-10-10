//
//  MainServerService.swift
//  My news
//
//  Created by Stanislav Slipchenko on 09.10.2020.
//

import Foundation
import Kingfisher

protocol MainServerServiceProtocol: class {
    var news: News? {get set}
    var images: [String : UIImageView?]? {get set}
    func loadNews()
}

class MainServerService: MainServerServiceProtocol {
    
    private let apiKey = "28d2250865c9496296dd09e61ef40ddc"
    var news: News?
    var images: [String : UIImageView?]?
    let image = UIImageView()
    
    func loadNews() {
        let configurator = URLSessionConfiguration.default
        let session = URLSession(configuration: configurator)
        var urlConstructor = URLComponents()
        
        urlConstructor.scheme = "https"
        urlConstructor.host = "newsapi.org"
        urlConstructor.path = "/v2/top-headlines"
        urlConstructor.queryItems = [
            URLQueryItem(name: "country", value: "ru"),
            URLQueryItem(name: "apiKey", value: self.apiKey),
            URLQueryItem(name: "pageSize", value: "100")]
        
        guard let url = urlConstructor.url else {return}
        
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            
            let news = try? JSONDecoder().decode(News.self, from: data)
            
            
            self.news = news
            
            self.news?.articles.forEach({ (articles) in
                guard let imageUrl = articles.urlToImage else {return}
                
                let url = URL(string: imageUrl )
//                self.image.kf.setImage(with: url)
//                self.images?[imageUrl] = self.image
            })
        }.resume()
    }
}
