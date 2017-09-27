//
//  Converter.swift
//  SwiftStone
//
//  Created by Carl Wieland on 9/25/17.
//  Copyright © 2017 Datum Apps. All rights reserved.
//

import Foundation
import Capstone

public class Converter {

    let buffer: Data
    let handle: csh
    internal init(handle: csh, buffer: Data) {
        self.buffer = buffer
        self.handle = handle
    }

    public func instruction(at address: UInt64) -> Instruction? {
        var instPointer: UnsafeMutablePointer<cs_insn>?

        defer {
            if let ptr = instPointer {
                cs_free(ptr, 1)
            }
        }

        let disassembleCount = buffer.withUnsafeBytes { (ptr: UnsafePointer<UInt8>) -> Int in
            let shifted = ptr.advanced(by: Int(address))
            return cs_disasm(handle, shifted, buffer.count - Int(address), address, 1, &instPointer)
        }

        if disassembleCount != 1 {
            return nil
        }
        guard let inst = instPointer?.pointee else {
            return nil
        }
        return Instruction(instruction: inst)

    }

    public func startConverting(at address: UInt64, handler: (Instruction?) -> Bool) {

        let insn = cs_malloc(handle);

        defer {
            if let ptr = insn {
                cs_free(ptr, 1);
            }
        }

        var keepGoing = true
        var size = buffer.count - Int(address)
        var addr = address
        buffer.withUnsafeBytes { (ptr: UnsafePointer<UInt8>) -> Void in
            var shifted: UnsafePointer? = ptr.advanced(by: Int(address))

            while keepGoing && cs_disasm_iter(handle, &shifted, &size, &addr, insn) {
                var instr: Instruction?
                if let actual = insn?.pointee {
                    instr = Instruction(instruction: actual)
                }
                keepGoing = handler(instr)
            }
            return
        }

    }
}

