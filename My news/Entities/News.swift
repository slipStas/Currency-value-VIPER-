//
//  News.swift
//  My news
//
//  Created by Stanislav Slipchenko on 09.10.2020.

import UIKit

// MARK: - News
class News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
    
    init(status: String, totalResults: Int, articles: [Article]) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
    
    required init(from decoder: Decoder) throws {
        let newsModel = try decoder.container(keyedBy: CodingKeys.self)
        
        self.status = try! newsModel.decode(String.self, forKey: .status)
        self.totalResults = try! newsModel.decode(Int.self, forKey: .totalResults)
        self.articles = try! newsModel.decode([Article].self, forKey: .articles)
    }
}

// MARK: - Article
class Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let articleDescription: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
    var imageNews: UIImage?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
    
    required init(from decoder: Decoder) throws {
        let article = try decoder.container(keyedBy: CodingKeys.self)
        
        self.source = try! article.decode(Source.self, forKey: .source)
        self.author = try? article.decode(String.self, forKey: .author)
        self.title = try! article.decode(String.self, forKey: .title)
        self.articleDescription = try? article.decode(String.self, forKey: .articleDescription)
        self.url = try! article.decode(String.self, forKey: .url)
        self.urlToImage = try? article.decode(String.self, forKey: .urlToImage)
        self.publishedAt = try! article.decode(String.self, forKey: .publishedAt)
        self.content = try? article.decode(String.self, forKey: .content)
//        self.imageNews = UIImage()
    }
}

// MARK: - Source
class Source: Codable {
    let id: String?
    let name: String
    
    required init(from decoder: Decoder) throws {
        let source = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? source.decode(String.self, forKey: .id)
        self.name = try! source.decode(String.self, forKey: .name)
    }
}
