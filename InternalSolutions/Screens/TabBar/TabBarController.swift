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
    }
    
    func observeViewModel() {
        viewModel.$screensState
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] state in
                        switch state {
                        case .loading:
                            print("Loading screens...")
                        case .error:
                            print("Failed to load screens.")
                        case .success(let viewControllers):
                            self?.viewControllers = viewControllers
                        }
                    }
                    .store(in: &cancellables)
                
                viewModel.initialize()
            }
}
