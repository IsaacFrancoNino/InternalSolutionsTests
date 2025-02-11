//
//  AppCoordinator.swift
//  InternalSolutions
//
//  Created by Trainee on 2/11/25.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        @Inject var viewController: FakeLoginViewController
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToTabBar() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        addChild(tabBarCoordinator)
        tabBarCoordinator.start()
    }
}
