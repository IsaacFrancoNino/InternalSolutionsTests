//
//  ViewController.swift
//  InternalSolutions
//
//  Created by Trainee on 1/30/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    let text: UILabel = {
        let textView = UILabel()
        textView.text = NSLocalizedString("HomeVC_label_text", comment: "Label text")
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLabel()
    }
    
    private func setupLabel() {
        view.addSubview(text)
        NSLayoutConstraint.activate([
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

