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
            sleep(1)
            do {
                let screensResponse = try await service.fetchScreens()
                let screens = screensResponse.screens
                await getViewControllers(screens: screens)
            } catch {
                await MainActor.run {
                    screensState = .error(NSLocalizedString("TabBarVM_error_message", comment: "Error message"))
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
            let holidaysService = MockHolidaysServiceImpl()
            let holidaysVM = HolidaysViewModel(service: holidaysService)
            return UIHostingController(rootView: HolidaysViewController(viewModel: holidaysVM))
        case "TESTWEBVIEW":
            let testWebViewVM = TestWebViewViewModel()
            return TestWebViewViewController(viewModel: testWebViewVM)
        default:
            return nil
        }
    }
}

enum ScreensState {
    case loading
    case error(String)
    case success([UIViewController])
}
