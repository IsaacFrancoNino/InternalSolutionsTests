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
    
    var viewModel: TestWebViewViewModel
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
        fatalError(NSLocalizedString("TestWebViewVC_fatal_error", comment: "Fatal error message"))
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
        let alertMessage = UIAlertController(title: NSLocalizedString("TestWebViewVC_alert_error_title", comment: "Alert Title"), message: errorMessage, preferredStyle: .alert)
        alertMessage.addAction(UIAlertAction(title: NSLocalizedString("TestWebViewVC_alert_error_button_text", comment: "Button action label"), style: .default))
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
            DispatchQueue.main.async {
                switch state {
                case .loading:
                    self.showLoader()
                case .error(let message):
                    self.show(errorMessage: message)
                    self.hideLoader()
                case .success(let request): self.webView.load(request)
                    self.hideLoader()
                }
            }
        }
        .store(in: &cancellables)
        viewModel.getPage()
    }
}
