//
//  Container.swift
//  InternalSolutions
//
//  Created by Trainee on 2/10/25.
//

import Foundation

class Container {
    private var registrations: [ObjectIdentifier: Any] = [:]
    
    func register<T>(_ type: T.Type, factory: @escaping ()-> T) {
        let key = ObjectIdentifier(type)
        registrations[key] = factory
    }
    
    func resolve<T>(_ type: T.Type) -> T? {
        let key = ObjectIdentifier(type)
        guard let factory = registrations[key] as? () -> T else { return nil }
        return factory()
    }
}
