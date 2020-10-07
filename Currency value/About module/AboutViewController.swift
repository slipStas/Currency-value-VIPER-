//
//  AboutViewController.swift
//  Currency value
//
//  Created by Stanislav Slipchenko on 07.10.2020.
//

import UIKit

protocol AboutViewProtocol: class {
    func setUrlButtonTitle(with title: String)
    func setDescriptionLabel(with title: String)
    func setThanksForLabel(with title: String)
}

class AboutViewController: UIViewController, AboutViewProtocol {
    
    @IBOutlet weak var urlButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var thanksForLabel: UILabel!
    
    var presenter: AboutPresenterProtocol!
    var configurator: AboutConfiguratorProtocol = AboutConfigurator()
    
    @IBAction func closeButtonClicked(_ sender: UIBarButtonItem) {
        presenter.closeButtonClicked()
    }
    @IBAction func urlButtonClicked(_ sender: UIButton) {
        presenter.urlButtonClicked(with: sender.currentTitle!)
    }
    
    func setUrlButtonTitle(with title: String) {
        urlButton.setTitle(title, for: .normal)
    }
    
    func setDescriptionLabel(with title: String) {
        descriptionLabel.text = title
    }
    
    func setThanksForLabel(with title: String) {
        thanksForLabel.text = title
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView()
    }
}
