//
//  FakeLogin.swift
//  InternalSolutions
//
//  Created by Trainee on 2/3/25.
//

import Foundation
import UIKit
class FakeLoginViewController:  UIViewController {
    
    weak var coordinator: AppCoordinator?
    
    let button: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle(NSLocalizedString("FakeLoginVC_button_title", comment: "Button title"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func goToTabBarView() {
//        @Inject var tabBarVC: TabBarController
//        navigationController?.pushViewController(tabBarVC, animated: true)
        coordinator?.goToTabBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupButton()
        button.addTarget(self, action: #selector(goToTabBarView), for: .touchUpInside)
    }
    
    private func setupButton() {
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
