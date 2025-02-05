//
//  TabBarController.swift
//  InternalSolutions
//
//  Created by Trainee on 2/3/25.
//

import Foundation
import UIKit
import SwiftUI
import Combine

class TabBarController: UITabBarController {
    
    let viewModel: TabBarViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        observeViewModel()
        setupLoader()
    }
    
    func setupLoader() {
        view.addSubview(loader)
        NSLayoutConstraint.activate ([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func showLoader() {
        loader.startAnimating()
    }
    
    func hideLoader() {
        loader.stopAnimating()
    }
    
    func show(errorMessage: String) {
        let alertMessage = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alertMessage.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertMessage,animated: true)
    }
    
    func observeViewModel() {
        viewModel.$screensState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .loading:
                    self?.showLoader()
                case .error(let message):
                    self?.show(errorMessage: message)
                    self?.hideLoader()
                case .success(let viewControllers):
                    self?.viewControllers = viewControllers
                    self?.hideLoader()
                }
            }
            .store(in: &cancellables)
        viewModel.initialize()
    }
}
