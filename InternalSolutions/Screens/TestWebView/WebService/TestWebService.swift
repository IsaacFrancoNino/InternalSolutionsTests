//
//  TestWebService.swift
//  InternalSolutions
//
//  Created by Trainee on 2/19/25.
//

import Foundation

protocol TestWebService: AnyObject {
    func getPage(route: String) async throws -> URLRequest
}

class TestWebServiceImpl : TestWebService {
    
    func getPage(route: String) async throws -> URLRequest {
        guard let url = URL(string: route) else { throw WebServiceError.invalidUrl }
            let request = URLRequest(url: url)
            return request
    }
}

enum WebServiceError : Error {
    case invalidUrl
    case noResponse
}
