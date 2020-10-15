//
//  MainViewController.swift
//  My news
//
//  Created by Stanislav Slipchenko on 07.10.2020.
//

import UIKit

protocol MainViewProtocol: class {
    
    var categoryOfRequest: CategoriesOfRequest {get set}
    func reloadData()
    func show(news: News?)
}

enum CategoriesOfRequest: String {
    case general = "general"
    case business = "business"
    case entertainment = "entertainment"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
}

class MainViewController: UIViewController {
    
    var categoryOfRequest: CategoriesOfRequest
    var presenter: MainPresenterProtocol!
    var configurator: MainConfiguratorProtocol = MainConfigurator()
    var news: News?
    let refreshControl = UIRefreshControl()
    
    //MARK: - declare views
    let infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let newsTableView: UITableView = {
        let table = UITableView()
        table.register(MainTableViewCell.self, forCellReuseIdentifier: "news table cell")
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryLabel.text = categoryTextChangeToRU(englishText: categoryOfRequest)
        configurator.configure(with: self)
        presenter.configureView(with: self.categoryOfRequest, completionHandler: {})

        addViews()
        newsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshNewsData), for: .valueChanged)
        self.infoButton.addTarget(self, action: #selector(infoButtonPressed), for: .touchUpInside)
        
        newsTableView.dataSource = self
        newsTableView.delegate = self
    }
    
    init(categoryOfRequest: CategoriesOfRequest) {
        self.categoryOfRequest = categoryOfRequest
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - declare methods
    @objc func infoButtonPressed() {
        presenter.infoButtonClicked()
    }
    
    func categoryTextChangeToRU(englishText: CategoriesOfRequest) -> String {
        switch englishText {
        case .business:
            return "Авто"
        case .entertainment:
            return "Шоу-бизнесс"
        case .general:
            return "Общее"
        case .health:
            return "Медицина"
        case .science:
            return "Наука"
        case .sports:
            return "Спорт"
        case .technology:
            return "Технологии"
        }
    }
    
    func addViews() {
        
        view.addSubview(infoButton)
        view.addSubview(newsTableView)
        view.addSubview(categoryLabel)
                
        infoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 44).isActive = true
        infoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        infoButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        infoButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        categoryLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 44).isActive = true
        categoryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        categoryLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        newsTableView.topAnchor.constraint(equalTo: self.infoButton.bottomAnchor, constant: 8).isActive = true
        newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

//MARK: - extensions
extension MainViewController: MainViewProtocol {
    
    @objc func refreshNewsData() {
        presenter.configureView(with: self.categoryOfRequest, completionHandler: {
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
