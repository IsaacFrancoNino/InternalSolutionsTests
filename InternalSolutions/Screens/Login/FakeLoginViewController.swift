//
//  FakeLogin.swift
//  InternalSolutions
//
//  Created by Trainee on 2/3/25.
//

import Foundation
import UIKit
class FakeLoginViewController:  UIViewController {
    
    let button: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle(NSLocalizedString("FakeLoginVC_button_title", comment: "Button title"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func goToHomeView() {
        let mockService = TabBarMockServiceImpl()
        let tabBarVM = TabBarViewModel(service: mockService)
        let tabBarVC = TabBarController(viewModel: tabBarVM)
        navigationController?.pushViewController(tabBarVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupButton()
        button.addTarget(self, action: #selector(goToHomeView), for: .touchUpInside)
    }
    
    private func setupButton() {
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
