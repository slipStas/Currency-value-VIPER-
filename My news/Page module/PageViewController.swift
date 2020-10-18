//
//  PageViewController.swift
//  My news
//
//  Created by Stanislav Slipchenko on 13.10.2020.
//

import UIKit

protocol PageViewProtocol: class {
    var newsViewControllers: [MainViewController] {get set}
}

class PageViewController: UIPageViewController, PageViewProtocol {
    
    var newsViewControllers: [MainViewController] = []
    var presenter: PagePresenterProtocol!
    var configurator: PageConfiguratorProtocol = PageConfigurator()
    let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.searchBarStyle = .prominent
        bar.placeholder = "search here..."
        bar.sizeToFit()
        
        return bar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(tapInfoButton))
        view.backgroundColor = .systemBackground
        setViewControllers([self.newsViewControllers[0]], direction: .forward, animated: true, completion: nil)
        
        self.dataSource = self
        self.delegate = self
        self.searchBar.delegate = self
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        configurator.configure(with: self)
        presenter.configureViewWithHeadliners {}
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapInfoButton() {
        presenter.infoButtonClicked()
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        self.newsViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewController = viewController as? MainViewController else {return nil}
        
        if let index = self.newsViewControllers.firstIndex(of: viewController) {
            if index > 0 {
                self.searchBar.text?.removeAll()
                return self.newsViewControllers[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewController = viewController as? MainViewController else {return nil}
        
        if let index = self.newsViewControllers.firstIndex(of: viewController) {
            if index < newsViewControllers.count - 1 {
                self.searchBar.text?.removeAll()
                return self.newsViewControllers[index + 1]
            }
        }
        return nil
    }
}

extension PageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search text did change to \(searchText)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        if self.newsViewControllers.count == 7 {
            self.presenter.configureViewWithEverything(searchTex: self.searchBar.text) {
                self.setViewControllers([self.newsViewControllers[0]], direction: .forward, animated: true, completion: nil)
            }
        } else {
            self.newsViewControllers.first?.presenter.configureViewWith(searchText: self.searchBar.text!, completionHandler: {
                self.newsViewControllers.first?.reloadData()
                print("reload data")
            })
        }
    }
}
