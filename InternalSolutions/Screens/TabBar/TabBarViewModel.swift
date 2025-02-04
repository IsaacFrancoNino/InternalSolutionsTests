//
//  TabBarViewModel.swift
//  InternalSolutions
//
//  Created by Trainee on 2/4/25.
//

import Foundation
import UIKit
import SwiftUI

class TabBarViewModel {
    @Published var screensState: ScreensState = .loading
    var service: TabBarService
    
    init(service: TabBarService) {
        self.service = service
    }
    
    func initialize() {
        screensState = .loading
        Task {
            do {
                let screensResponse = try await service.fetchScreens()
                let screens = screensResponse.screens
                await getViewControllers(screens: screens)
            } catch {
                await MainActor.run {
                    screensState = .error
                }
            }
        }
    }
    @MainActor
    func getViewControllers(screens: [ScreenInfo]) {
        var viewControllers = [UIViewController]()
        for screen in screens {
            for detail in screen.data {
                guard let vc = createViewController(title: detail.title) else {return}
                let navigationController = UINavigationController(rootViewController: vc)
                navigationController.tabBarItem = UITabBarItem(title: detail.title, image: UIImage(systemName: detail.icon), selectedImage: UIImage(systemName: "\(detail.icon).fill"))
                
                viewControllers.append(navigationController)
            }
        }
        screensState = .success(viewControllers)
    }
    
    
    private func createViewController(title: String) -> UIViewController? {
        switch title {
        case "HOME":
            return HomeViewController()
        case "HOLIDAYS":
            return UIHostingController(rootView: HolidaysViewController())
        case "TESTWEBVIEW":
            return TestWebViewViewController()
        default:
            return nil
        }
    }
    
}

enum ScreensState {
    case loading
    case error
    case success([UIViewController])
}
