//
//  TestWebViewViewModel.swift
//  InternalSolutions
//
//  Created by Trainee on 2/5/25.
//

import Foundation

class TestWebViewViewModel {
    @Published var webViewState: WebViewState = .loading
    
    func getMockPage() {
        webViewState = .loading
        guard let url = URL(string: "https://rickandmortyapi.com/") else{ webViewState = .error(NSLocalizedString("TestWebViewVM_error_message", comment: "Error message"))
            return }
        let request = URLRequest(url: url)
        webViewState = .success(request)
    }
}

enum WebViewState {
    case loading
    case success(URLRequest)
    case error(String)
}
