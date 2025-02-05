//
//  TestWebViewViewController.swift
//  InternalSolutions
//
//  Created by Trainee on 2/4/25.
//

import Foundation
import UIKit
import WebKit
import Combine

class TestWebViewViewController: UIViewController {
    
    let viewModel: TestWebViewViewModel
    private var cancellables = Set<AnyCancellable>()
    
    let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    init(viewModel: TestWebViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
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
    
    func setupWebView() {
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func observeViewModel() {
        viewModel.$webViewState.sink { [weak self] state in
            guard let self else { return }
            switch state {
            case .loading:
                showLoader()
            case .error(let message):
                show(errorMessage: message)
                hideLoader()
            case .success(let request): webView.load(request)
                hideLoader()
            }
        }
        .store(in: &cancellables)
        viewModel.getMockPage()
    }
}
