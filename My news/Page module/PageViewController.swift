//
//  PageViewController.swift
//  My news
//
//  Created by Stanislav Slipchenko on 13.10.2020.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var newsViewControllers: [MainViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .brown

        addViewControllers()
                
        setViewControllers([self.newsViewControllers[0]], direction: .forward, animated: true, completion: nil)
        
        self.dataSource = self
        self.delegate = self
    }
    
    func addViewControllers() {
        print(newsViewControllers.count)
        let firstVC = MainViewController()
        let secondVC = MainViewController()

        newsViewControllers.append(contentsOf: [firstVC, secondVC])
        print(newsViewControllers.count)

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
                return self.newsViewControllers[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewController = viewController as? MainViewController else {return nil}
        
        if let index = self.newsViewControllers.firstIndex(of: viewController) {
            if index < newsViewControllers.count - 1 {
                return self.newsViewControllers[index + 1]
            }
        }
        return nil
    }
}
