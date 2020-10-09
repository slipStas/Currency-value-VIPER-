//
//  MainViewController.swift
//  My news
//
//  Created by Stanislav Slipchenko on 07.10.2020.
//

import UIKit

protocol MainViewProtocol: class {
    func reloadData()
    func show(news: News)
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    
    var presenter: MainPresenterProtocol!
    var configurator: MainConfiguratorProtocol = MainConfigurator()
    var news: News?
    
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
    func show(news: News) {
        self.news = news
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "mews table cell", for: indexPath) as! MainTableViewCell
        
        cell.titleLabel.text = news?.articles[indexPath.row].title
        cell.authorNameLabel.text = news?.articles[indexPath.row].author
        cell.descriptionLabel.text = news?.articles[indexPath.row].articleDescription
        cell.dateLabel.text = news?.articles[indexPath.row].publishedAt
        cell.showFullSizeNewsButton.setTitle(news?.articles[indexPath.row].urlToImage, for: .normal)
        
        let url = URL(string: (news?.articles[indexPath.row].urlToImage)!)
        let data = try? Data(contentsOf: url!)
        cell.imageOfNews.image = UIImage(data: data!)
        
        return cell
    }
    
}
