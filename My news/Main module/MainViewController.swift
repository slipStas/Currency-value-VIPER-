//
//  MainViewController.swift
//  My news
//
//  Created by Stanislav Slipchenko on 07.10.2020.
//

import UIKit

protocol MainViewProtocol: class {
    func reloadData()
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    
    var presenter: MainPresenter!
    var configurator: MainConfiguratorProtocol = MainConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    @IBAction func infoButtonPressed(_ sender: Any) {
        presenter.infoButtonClicked()
    }
}

extension MainViewController: MainViewProtocol {
    func reloadData() {
        newsTableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath) as! MainTableViewCell
        
        
        return cell
    }
    
}
