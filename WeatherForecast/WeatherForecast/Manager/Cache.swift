//
//  CacheData.swift
//  WeatherForecast
//
//  Created by Cuong Nguyen on 05/08/2020.
//  Copyright © 2020 Cuong Nguyen. All rights reserved.
//

import Foundation

final class Cache<Key: Hashable, Value> {
    private let wrapped = NSCache<WrappedKey, Entry>()
    
    func insert(_ value: Value, forKey key: Key, lifeTime: TimeInterval) {
        let now = Date()
        let expriedTime = now.addingTimeInterval(lifeTime)
        let entry = Entry(value: value, key: key, startDate: now, expirationTime: expriedTime)
        wrapped.setObject(entry, forKey: WrappedKey(key))
    }

    func value(forKey key: Key) -> Value? {
        guard let entry = wrapped.object(forKey: WrappedKey(key)) else { return nil }
        
        // Remove values that have expried date
        guard Date() < entry.expirationTime else {
            removeValue(forKey: key)
            return nil
        }
        
        return entry.value
    }

    func removeValue(forKey key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
    }
}

private extension Cache {
    final class WrappedKey: NSObject {
        let key: Key

        init(_ key: Key) {
            self.key = key
        }

        override var hash: Int {
            return key.hashValue
        }

        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }

            return value.key == key
        }
    }
}

private extension Cache {
    final class Entry {
        let value: Value
        let key: Key
        let startDate: Date
        let expirationTime: Date

        init(value: Value, key: Key, startDate: Date, expirationTime: Date) {
            self.value = value
            self.key = key
            self.startDate = startDate
            self.expirationTime = expirationTime
        }
    }
}
