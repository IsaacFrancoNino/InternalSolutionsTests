//
//  TabBarCoordinator.swift
//  InternalSolutions
//
//  Created by Trainee on 2/11/25.
//

import Foundation
import UIKit

class TabBarCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init( navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        @Inject var viewController: TabBarController
        navigationController.setViewControllers([viewController],animated: true)
    }
}
