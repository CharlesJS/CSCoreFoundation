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

    public static func make(_ status: OSStatus) -> CFError {
        let domain: CFString
        let code: CFIndex

        let posixErrorBase: OSStatus = 100000

        if (posixErrorBase..<(posixErrorBase + 1000)).contains(status) {
            domain = CFString.fromString("NSPOSIXErrorDomain")
            code = CFIndex(status - posixErrorBase)
        } else {
            domain = CFString.fromString("NSOSStatusErrorDomain")
            code = CFIndex(status)
        }

        return CFErrorCreate(kCFAllocatorDefault, domain, code, nil)
    }
}
