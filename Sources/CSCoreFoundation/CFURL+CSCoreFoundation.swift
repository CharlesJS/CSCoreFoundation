//
//  CFURL+CSCoreFoundation.swift
//  CSCoreFoundation
//
//  Created by Charles Srstka on 7/22/21.
//

import CoreFoundation

extension CFURL {
    public func withUnsafeFileSystemRepresentation<T>(closure: (UnsafePointer<CChar>) throws -> T) rethrows -> T {
        let bufferSize = Int(PATH_MAX) + 1

        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        defer { buffer.deallocate() }

        CFURLGetFileSystemRepresentation(self, true, buffer, bufferSize)

        return try buffer.withMemoryRebound(to: CChar.self, capacity: bufferSize) { try closure($0) }
    }
}
