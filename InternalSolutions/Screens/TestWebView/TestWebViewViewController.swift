//
//  TestWebViewViewController.swift
//  InternalSolutions
//
//  Created by Trainee on 2/4/25.
//

import Foundation
import UIKit
import WebKit

class TestWebViewViewController: UIViewController {
    
    let webView = WKWebView()
    
    override func loadView() {
        self.view = webView
        
        if let url = URL(string: "https://rickandmortyapi.com/"){
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
