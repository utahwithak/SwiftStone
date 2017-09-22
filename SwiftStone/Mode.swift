//
//  Mode.swift
//  SwiftStone
//
//  Created by Carl Wieland on 9/21/17.
//  Copyright © 2017 Datum Apps. All rights reserved.
//

import Foundation
import Capstone

enum Mode {
    /// little-endian mode (default mode)
    case littleEndian
    /// 32-bit ARM
    case arm
    ///16-bit mode (X86)
    case x86_16Bit
    /// 32-bit mode (X86)
    case x86_32Bit
    /// 64-bit mode (X86, PPC)
    case x86_64Bit
    /// ARM's Thumb mode, including Thumb-2
    case thumb
    /// ARM's Cortex-M series
    case mClass
    /// ARMv8 A32 encodings for ARM
    case v8
    /// MicroMips mode (MIPS)
    case microMips
    /// Mips III ISA
    case mips3
    /// Mips32r6 ISA
    case mips32r6
    /// General Purpose Registers are 64-bit wide (MIPS)
    case mipsgp64
    /// SparcV9 mode (Sparc)
    case v9
    /// big-endian mode
    case bigEndian
    /// Mips32 ISA (Mips)
    case mips32
    /// Mips64 ISA (Mips)
    case mips64

    var rawMode: cs_mode {
        switch self {
        case .littleEndian:
            return CS_MODE_LITTLE_ENDIAN
        case .arm:
            return CS_MODE_ARM
        case .x86_16Bit:
            return CS_MODE_16
        case .x86_32Bit:
            return CS_MODE_32
        case .x86_64Bit:
            return CS_MODE_64
        case .thumb:
            return CS_MODE_THUMB
        case .mClass:
            return CS_MODE_MCLASS
        case .v8:
            return CS_MODE_V8
        case .microMips:
            return CS_MODE_MICRO
        case .mips3:
            return CS_MODE_MIPS3
        case .mips32r6:
            return CS_MODE_MIPS32R6
        case .mipsgp64:
            return CS_MODE_MIPSGP64
        case .v9:
            return CS_MODE_V9
        case .bigEndian:
            return CS_MODE_BIG_ENDIAN
        case .mips32:
            return CS_MODE_MIPS32
        case .mips64:
            return CS_MODE_MIPS64
        }
    }

}
