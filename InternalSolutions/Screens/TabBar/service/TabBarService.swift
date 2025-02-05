//
//  TabBarMockService.swift
//  InternalSolutions
//
//  Created by Trainee on 2/4/25.
//

import Foundation

protocol TabBarService {
    func fetchScreens() async throws -> ScreensResponse
}


class TabBarMockServiceImpl: TabBarService {
    
    private let decoder: JSONDecoder = JSONDecoder()
    func fetchScreens() async throws -> ScreensResponse {
        guard let url = Bundle.main.url(forResource: "mockScreens", withExtension: "json") else {
            throw NSError(domain: "FileNotFound", code: 404, userInfo: nil)
        }
        do {
            let data = try Data(contentsOf: url)
            let screensInfo = try decoder.decode(ScreensResponse.self, from: data)
            return screensInfo
        } catch {
            throw error
        }
    }
}
