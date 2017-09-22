//
//  SwiftStone.swift
//  SwiftStone
//
//  Created by Carl Wieland on 9/21/17.
//  Copyright © 2017 Datum Apps. All rights reserved.
//

import Foundation
import Capstone

class SwiftStone {

    private var handle: csh = 0
    let arch: Architecture
    let mode: Mode

    init(arch: Architecture = .x86, mode: Mode = .littleEndian) throws {
        self.arch = arch
        self.mode = mode


        let rc = cs_open(arch.arch, mode.rawMode, &handle)
        if rc != CS_ERR_OK {
            throw NSError(domain: "SwiftStone", code: Int(rc.rawValue), userInfo: [NSLocalizedDescriptionKey:"Failed to initialize csh"])
        }
    }

    deinit {
        cs_close(&handle)
    }
}
