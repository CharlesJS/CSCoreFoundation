//
//  CFError+CSCoreFoundation.swift
//  CSCoreFoundation
//
//  An extension to give CFError conformance to the Error protocol
//  without requiring your tool to link against Foundation.
//
//  Created by Charles Srstka on 7/20/21.
//

import CoreFoundation

extension CFError: Error {
    public var _domain: String { CFErrorGetDomain(self).toString() }
    public var _code: Int { Int(CFErrorGetCode(self)) }
    public var _userInfo: AnyObject? { CFErrorCopyUserInfo(self) }

    public static func make<I: BinaryInteger>(domain: String, code: I, userInfo: CFDictionary? = nil) -> CFError {
        CFErrorCreate(kCFAllocatorDefault, CFString.fromString(domain), CFIndex(code), userInfo)
    }

    public static func make<I: BinaryInteger>(posixError: I, userInfo: CFDictionary? = nil) -> CFError {
        self.make(domain: "NSPOSIXErrorDomain", code: CFIndex(posixError), userInfo: userInfo)
    }

    public static func make(osStatus status: OSStatus, userInfo: CFDictionary? = nil) -> CFError {
        let posixErrorBase: OSStatus = 100000
        if (posixErrorBase..<(posixErrorBase + 1000)).contains(status) {
            return self.make(posixError: status - posixErrorBase)
        } else {
            return self.make(domain: "NSOSStatusErrorDomain", code: CFIndex(status), userInfo: userInfo)
        }
    }
}
