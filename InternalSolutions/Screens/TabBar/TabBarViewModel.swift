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
    
    @Inject var service: TabBarService
    
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
            @Inject var HomeVC: HomeViewController
            return HomeVC
        case "HOLIDAYS":
            @Inject var HolidaysVC: HolidaysViewController
            return UIHostingController(rootView: HolidaysVC )
        case "TESTWEBVIEW":
            @Inject var webViewVC:TestWebViewViewController
            return webViewVC
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
