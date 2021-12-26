//
//  CFArray+CSCoreFoundation.swift
//  CSCoreFoundation
//
//  Created by Charles Srstka on 7/22/21.
//

import CoreFoundation

extension CFArray {
    public subscript<I: BinaryInteger>(index: I) -> CFTypeRef? {
        unsafeBitCast(CFArrayGetValueAtIndex(self, CFIndex(index)), to: CFTypeRef?.self)
    }

    public subscript<I: BinaryInteger, T: CFTypeRef>(index: I, as typeID: CFTypeID) -> T? {
        guard let value = self[index], CFGetTypeID(value) == typeID else { return nil }

        return value as? T
    }
}
