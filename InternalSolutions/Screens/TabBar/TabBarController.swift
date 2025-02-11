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
    
    @Inject var viewModel: TabBarViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.hidesBackButton = true
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
        let alertMessage = UIAlertController(title: NSLocalizedString("TabBarController_alert_error_title", comment: "Alert title"), message: errorMessage, preferredStyle: .alert)
        alertMessage.addAction(UIAlertAction(title: NSLocalizedString("TabBarController_alert_error_button_text", comment: "Action Text"), style: .default))
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
