//
//  MainViewController.swift
//  My news
//
//  Created by Stanislav Slipchenko on 07.10.2020.
//

import UIKit
import Kingfisher

protocol MainViewProtocol: class {
    func reloadData()
    func show(news: News, images: [String : UIImageView?]?)
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    
    var presenter: MainPresenterProtocol!
    var configurator: MainConfiguratorProtocol = MainConfigurator()
    var news: News?
    var images: [String : UIImageView?]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        newsTableView.dataSource = self
    }
    
    @IBAction func infoButtonPressed(_ sender: Any) {
        presenter.infoButtonClicked()
    }
}

extension MainViewController: MainViewProtocol {
    func show(news: News, images: [String : UIImageView?]?) {
        self.news = news
        self.images = images
    }
    
    func reloadData() {
        newsTableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news?.totalResults ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "news table cell", for: indexPath) as! MainTableViewCell
        
        cell.titleLabel.text = news?.articles[indexPath.row].title
        cell.authorNameLabel.text = news?.articles[indexPath.row].author
        cell.descriptionLabel.text = news?.articles[indexPath.row].articleDescription
        cell.dateLabel.text = news?.articles[indexPath.row].publishedAt
        cell.showFullSizeNewsButton.setTitle(news?.articles[indexPath.row].url, for: .normal)
        
        // TODO: - fix it
        
        let url = URL(string: (news?.articles[indexPath.row].urlToImage) ?? "")
        
        cell.imageOfNews.kf.setImage(with: url)  
        
        return cell
    }
    
}
