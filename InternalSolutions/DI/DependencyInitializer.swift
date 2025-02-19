//
//  DependencyInitializer.swift
//  InternalSolutions
//
//  Created by Trainee on 2/10/25.
//

import Foundation

class DependencyInitializer {
    static let container = Container()
    
    init() {
        addDependencies(to: DependencyInitializer.container)
    }
    
    func addDependencies (to container: Container) {
        
        // MARK: TabBar Dependencies
        container.register(TabBarService.self) {
            TabBarMockServiceImpl()
        }
        container.register(TabBarViewModel.self) {
            TabBarViewModel()
        }
        container.register(TabBarController.self) {
            TabBarController()
        }
        
        // MARK: HolidaysScreen Dependencies
        container.register(HolidaysService.self) {
            MockHolidaysServiceImpl()
        }
        container.register(HolidaysViewModel.self) {
            HolidaysViewModel()
        }
        container.register(HolidaysViewController.self) {
            HolidaysViewController()
        }
        
        //MARK: TestWebService Dependencies
        container.register(TestWebService.self) {
            TestWebServiceImpl()
        }
        
        // MARK: WebViewScreen Dependencies
        container.register(TestWebViewViewModel.self) { (route: String) in
            guard let service = DependencyInitializer.container.resolve(TestWebService.self) else {
                    fatalError("TestWebService dependency is missing!")
                }
            return TestWebViewViewModel(service: service, route: route)
        }
        
        container.register(TestWebViewViewController.self) { (viewModel: TestWebViewViewModel) in
            TestWebViewViewController(viewModel: viewModel)
        }
        
        // MARK: HomeViewScreen Dependencies
        container.register(HomeViewController.self) {
            HomeViewController()
        }
        
        // MARK: FakeLoginScreen Dependencies
        container.register(FakeLoginViewController.self) {
            FakeLoginViewController()
        }
    }
}
