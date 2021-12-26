//
//  CFDictionary+CSCoreFoundation.swift
//  CSCoreFoundation
//
//  Created by Charles Srstka on 7/22/21.
//

import CoreFoundation

extension CFDictionary {
    public subscript(key: String) -> CFTypeRef? {
        self[CFString.fromString(key)]
    }

    public subscript<T: CFTypeRef>(key: String, as typeID: CFTypeID) -> T? {
        self[CFString.fromString(key), as: typeID]
    }

    public subscript(key: CFTypeRef) -> CFTypeRef? {
        return unsafeBitCast(
            CFDictionaryGetValue(self, unsafeBitCast(key, to: UnsafeRawPointer.self)),
            to: CFTypeRef?.self
        )
    }

    public subscript<T: CFTypeRef>(key: CFTypeRef, as typeID: CFTypeID) -> T? {
        guard let value = self[key], CFGetTypeID(value) == typeID else { return nil }

        return value as? T
    }

    public func readString(key: String) -> String? {
        self.readString(key: CFString.fromString(key))
    }

    public func readString(key: CFString) -> String? {
        let string: CFString? = self[key, as: CFStringGetTypeID()]

        return string?.toString()
    }
}
