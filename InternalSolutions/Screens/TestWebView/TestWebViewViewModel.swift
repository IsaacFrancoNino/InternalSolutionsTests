//
//  TestWebViewViewModel.swift
//  InternalSolutions
//
//  Created by Trainee on 2/5/25.
//

import Foundation

class TestWebViewViewModel {
    @Published var webViewState: WebViewState = .loading
    private var service: TestWebService
    private var route: String
    
    init(service: TestWebService, route: String) {
        self.service = service
        self.route = route
    }
    
    
    func getMockPage() {
        webViewState = .loading
        guard let url = URL(string: "https://rickandmortyapi.com/") else { webViewState = .error(NSLocalizedString("TestWebViewVM_error_message", comment: "Error message"))
            return }
        let request = URLRequest(url: url)
        webViewState = .success(request)
    }
    
    func getPage() {
        webViewState = .loading
        Task {
            do {
                let response = try await service.getPage(route: route)
                webViewState = .success(response)
            } catch {
                webViewState = .error(error.localizedDescription)
            }
        }
    }
}

enum WebViewState {
    case loading
    case success(URLRequest)
    case error(String)
}
