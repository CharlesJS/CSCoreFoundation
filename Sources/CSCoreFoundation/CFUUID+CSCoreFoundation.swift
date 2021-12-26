//
//  CFUUID+CSCoreFoundation.swift
//  CSCoreFoundation
//
//  Created by Charles Srstka on 7/22/21.
//

import CoreFoundation

extension CFUUID {
    public func toString() -> String {
        CFUUIDCreateString(kCFAllocatorDefault, self).toString()
    }
}
