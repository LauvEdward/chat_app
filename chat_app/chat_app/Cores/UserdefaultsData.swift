//
//  UserdefaultsData.swift
//  chat_app
//
//  Created by Admin on 11/14/21.
//

import Foundation
class UserdefaultsData {
    func fetch<T>(key: String, type: T.Type) -> T? {
        switch type.self {
        case is String.Type:
            guard let value = UserDefaults.standard.string(forKey: key) as? T else { return nil }
            return value
        case is Float.Type:
            guard let value = UserDefaults.standard.float(forKey: key) as? T else { return nil }
            return value
        case is Data.Type:
            guard let value = UserDefaults.standard.data(forKey: key) as? T else { return nil }
            return value
        case is Int.Type:
            guard let value = UserDefaults.standard.float(forKey: key) as? T else { return nil }
            return value
        case is Bool.Type:
            guard let value = UserDefaults.standard.bool(forKey: key) as? T else { return nil }
            return value
        case is [String].Type:
            guard let value = UserDefaults.standard.object(forKey: key) as? T else { return nil }
            return value
        default:
            return nil
        }
    }
    
    func save<T>(_ key: String, _ value: T) {
        UserDefaults.standard.set(T.self, forKey: key)
    }
    
    func delete(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    func deleteAll() {
        UserDefaults.standard.removeAll()
    }
    
}

extension UserDefaults {
    func removeAll() {
        dictionaryRepresentation().forEach { removeObject(forKey: $0.key) }
    }
}
