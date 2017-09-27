//
//  Architecture.swift
//  SwiftStone
//
//  Created by Carl Wieland on 9/21/17.
//  Copyright © 2017 Datum Apps. All rights reserved.
//

import Foundation
import Capstone

public enum Architecture: UInt32 {

    /// ARM architecture (including Thumb, Thumb-2)
    case arm = 0
    // ARM-64, also called AArch64    internal var arch: cs_arch {
    case arm64
    /// Mips architecture
    case mips
    /// X86 architecture (including x86 & x86-64)    }
    case x86
    /// PowerPC architecture}
    case ppc
    /// Sparc architecture
    case sparc
    /// SystemZ architecture
    case sysz
    /// XCore architecture
    case xcore

     /// All architectures - for cs_support()
    case all = 0xFFFF
    
    internal var arch: cs_arch {
        return cs_arch(self.rawValue)
    }
}
