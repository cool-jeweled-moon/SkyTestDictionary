//
//  Locator.swift
//  SkyTestDictionary
//
//  Created by Борис Анели on 24.09.2020.
//

import Foundation
import JeweledKit

final class ServiceLocator: NSObject {
    
    static let shared = ServiceLocator()
    
    var registry = [String: Any]()
    
    func register<T>(key: T.Type, instance: T) {
        self.registry["\(T.self)"] = instance
    }
    
    func get<T>(_:T.Type) -> T? {
        return registry["\(T.self)"] as? T
    }
    
    func remove<T>(_: T.Type) {
        registry.removeValue(forKey: "\(T.self)")
    }
    
    func instance<T>(forKey key: T.Type, factory: @escaping () -> T) -> T {
        if let instance = get(key) {
            return instance
        } else {
            let instance = factory()
            register(key: key, instance: instance)
            return instance
        }
    }
    
}

extension ServiceLocator {
    
    func requestLoader() -> JeweledRequestLoaderProtocol {
        return instance(forKey: JeweledRequestLoader.self) {
            JeweledRequestLoader(errorParser: ErrorParser())
        }
    }
    
    func soundLoader() -> SoundLoader {
        return instance(forKey: SoundLoader.self) { SoundLoader() }
    }
}
