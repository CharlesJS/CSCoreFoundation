//
//  CFString+CSCoreFoundation.swift
//  CSCoreFoundation
//
//  Some helper methods to facilitate working with CFStrings without requiring your tool to link against Foundation.
//
//  Created by Charles Srstka on 7/20/21.
//

import CoreFoundation

extension CFString {
    public static func fromString(_ string: String) -> CFString {
        let utf8 = CFStringBuiltInEncodings.UTF8.rawValue
        return string.withCString { CFStringCreateWithCString(kCFAllocatorDefault, $0, utf8) }
    }

    public func toString() -> String {
        self.withCString { String(cString: $0) }
    }

    public func withCString<T>(
        encoding: CFStringEncoding = CFStringBuiltInEncodings.UTF8.rawValue,
        closure: (UnsafePointer<CChar>) throws -> T
    ) rethrows -> T {
        if let ptr = CFStringGetCStringPtr(self, encoding) {
            return try withExtendedLifetime(self) {
                try closure(ptr)
            }
        } else {
            let bufferSize = Int(CFStringGetMaximumSizeForEncoding(CFStringGetLength(self), encoding))
            let buffer = UnsafeMutablePointer<CChar>.allocate(capacity: bufferSize)
            defer { buffer.deallocate() }

            CFStringGetCString(self, buffer, bufferSize, encoding)
            return try closure(buffer)
        }
    }
}
