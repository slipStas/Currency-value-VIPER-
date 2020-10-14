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
    
//    @IBOutlet weak var newsTableView: UITableView!
    
    var presenter: MainPresenterProtocol!
    var configurator: MainConfiguratorProtocol = MainConfigurator()
    var news: News?
    let refreshControl = UIRefreshControl()
    
    //MARK: - UIViews
    let infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let newsTableView: UITableView = {
        let table = UITableView()
        table.register(MainTableViewCell.self, forCellReuseIdentifier: "news table cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView(completionHandler: {})

        self.view.backgroundColor = .white
        addViews()
        newsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshNewsData), for: .valueChanged)
        self.infoButton.addTarget(self, action: #selector(infoButtonPressed), for: .touchUpInside)
        newsTableView.dataSource = self
        newsTableView.delegate = self
    }
    
    @objc func infoButtonPressed() {
        presenter.infoButtonClicked()
    }
    
    func addViews() {
        view.addSubview(infoButton)
        view.addSubview(newsTableView)
        
        infoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 44).isActive = true
        infoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        infoButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        infoButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        newsTableView.topAnchor.constraint(equalTo: self.infoButton.bottomAnchor, constant: 8).isActive = true
        newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

        
    }
    
//    @IBAction func infoButtonPressed(_ sender: Any) {
//        presenter.infoButtonClicked()
//    }
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
