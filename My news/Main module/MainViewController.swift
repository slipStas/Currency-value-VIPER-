//
//  MainViewController.swift
//  My news
//
//  Created by Stanislav Slipchenko on 07.10.2020.
//

import UIKit

protocol MainViewProtocol: class {
    func reloadData()
    func show(news: News?)
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    
    var presenter: MainPresenterProtocol!
    var configurator: MainConfiguratorProtocol = MainConfigurator()
    var news: News?
    let refreshControl = UIRefreshControl()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView(completionHandler: {})
        
        newsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshNewsData), for: .valueChanged)

        newsTableView.dataSource = self
        newsTableView.delegate = self
    }
    
    
    
    @IBAction func infoButtonPressed(_ sender: Any) {
        presenter.infoButtonClicked()
    }
}

extension MainViewController: MainViewProtocol {
    
    @objc func refreshNewsData() {
        presenter.configureView(completionHandler: {
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
        })
    }
    
    func show(news: News?) {
        self.news = news
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.isSelected = false
        guard let urlString = news?.articles[indexPath.row].url else {return}
        presenter.goToSite(with: urlString)
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "news table cell", for: indexPath) as! MainTableViewCell
        
        var date: String
        
        if let dateNotNill = news?.articles[indexPath.row].publishedAt {
            date = dateNotNill
            date = date.replacingOccurrences(of: "T", with: "  ")
            date = date.replacingOccurrences(of: "Z", with: "")
            cell.dateLabel.text = date
        }
        
        cell.titleLabel.text = news?.articles[indexPath.row].title
        cell.descriptionLabel.text = news?.articles[indexPath.row].articleDescription
        cell.imageOfNews.image = news?.articles[indexPath.row].imageNews ?? UIImage(named: "loading")
        
        return cell
    }
}
