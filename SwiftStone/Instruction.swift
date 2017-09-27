//
//  Instruction.swift
//  SwiftStone
//
//  Created by Carl Wieland on 9/25/17.
//  Copyright © 2017 Datum Apps. All rights reserved.
//

import Foundation
import Capstone

public class Instruction: NSObject {

    let backingInst: cs_insn

    public let length: UInt64

    public var asmLine: String {
        return "\(mnemonic) \(opString)"
    }

    public let mnemonic: String

    public let opString: String

    init(instruction: cs_insn) {
        self.backingInst = instruction
        length = UInt64(backingInst.size)

        mnemonic = withUnsafePointer(to: &backingInst.mnemonic) { ptr in
            return ptr.withMemoryRebound(to: UInt8.self, capacity: 1, { converted in
                return String(cString: converted)
            })
        }

        opString = withUnsafePointer(to: &backingInst.op_str) { ptr in
            return ptr.withMemoryRebound(to: UInt8.self, capacity: 1, { converted in
                return String(cString: converted)
            })
        }


        var tmp = backingInst
        var error = cs_err(0)
        isCall = cs_insn_in_group(&tmp, CS_GRP_CALL.rawValue, &error)
        isJump = cs_insn_in_group(&tmp, CS_GRP_JUMP.rawValue, &error)
        isReturn = cs_insn_in_group(&tmp, CS_GRP_RET.rawValue, &error) || cs_insn_in_group(&tmp, CS_GRP_IRET.rawValue, &error)

        super.init()
    }

    public let isCall: Bool
    public let isJump: Bool
    public let isReturn: Bool
}

