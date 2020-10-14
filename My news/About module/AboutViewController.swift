//
//  AboutViewController.swift
//  My news
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
    
    //MARK: - declare views
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let thanksForLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        
        return label
    }()
    
    let urlButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var presenter: AboutPresenterProtocol!
    var configurator: AboutConfiguratorProtocol = AboutConfigurator()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupViews()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    //Mark: - declare methods
    @objc func closeButtonClicked() {
        presenter.closeButtonClicked()
    }
    
    @objc func urlButtonClicked() {
        presenter.urlButtonClicked(with: urlButton.currentTitle!)
    }
    
    func setupViews() {
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(emptyView)
        stackView.addArrangedSubview(thanksForLabel)
        stackView.addArrangedSubview(urlButton)
        
        view.addSubview(stackView)
        
        urlButton.addTarget(self, action: #selector(urlButtonClicked), for: .touchUpInside)

        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        emptyView.heightAnchor.constraint(equalToConstant: 20).isActive = true
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
}
