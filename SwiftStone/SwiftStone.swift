//
//  SwiftStone.swift
//  SwiftStone
//
//  Created by Carl Wieland on 9/21/17.
//  Copyright © 2017 Datum Apps. All rights reserved.
//

import Foundation
import Capstone

public class SwiftStone {

    private var handle: csh = 0
    let arch: Architecture
    var mode: Mode {
        didSet {
            cs_option(handle, CS_OPT_MODE, Int(mode.rawMode.rawValue))
        }
    }

    public init(arch: Architecture = .x86, mode: Mode = .littleEndian) throws {
        self.arch = arch
        self.mode = mode


        let rc = cs_open(arch.arch, mode.rawMode, &handle)
        if rc != CS_ERR_OK {
            throw NSError(domain: "SwiftStone", code: Int(rc.rawValue), userInfo: [NSLocalizedDescriptionKey:"Failed to initialize csh"])
        }
    }

    public var syntax: SSSyntax {
        set {
            cs_option(handle, CS_OPT_SYNTAX, newValue.optionValue)
        }
        get {
            var value = cs_opt_value(0)
            if cs_get_option(handle, CS_OPT_SYNTAX, &value) == CS_ERR_OK {
                return SSSyntax(value: value)
            }
            print("FAILED TO GET SYNTAX OPTION!!")
            return .default
        }
    }

    public var detail: Bool {
        set {
            cs_option(handle, CS_OPT_DETAIL, Int(newValue ? CS_OPT_ON.rawValue : CS_OPT_OFF.rawValue))
        }
        get {
            var value = cs_opt_value(0)
            if cs_get_option(handle, CS_OPT_DETAIL, &value) == CS_ERR_OK {
                return value == CS_OPT_ON
            }
            print("FAILED TO GET SYNTAX OPTION!!")
            return false
        }
    }

    public var skipData: Bool {
        set {
            cs_option(handle, CS_OPT_SKIPDATA, Int(newValue ? CS_OPT_ON.rawValue : CS_OPT_OFF.rawValue))
        }
        get {
            var value = cs_opt_value(0)
            if cs_get_option(handle, CS_OPT_SKIPDATA, &value) == CS_ERR_OK {
                return value == CS_OPT_ON
            }
            print("FAILED TO GET SYNTAX OPTION!!")
            return false

        }
    }

    deinit {
        cs_close(&handle)
    }

    public func converter(for data: Data) -> Converter {
        return Converter(handle: handle, buffer: data)
    }
    
}


public enum SSSyntax {
    case `default`
    case intel
    case att
    case noregname

    init( value: cs_opt_value) {
        switch value {
        case CS_OPT_SYNTAX_INTEL:
            self = .intel
        case CS_OPT_SYNTAX_ATT:
            self = .att
        case CS_OPT_SYNTAX_NOREGNAME:
            self = .noregname
        default:
            self = .default
        }
    }

    var optionValue: Int {
        switch self {
        case .default:
            return Int(CS_OPT_SYNTAX_DEFAULT.rawValue)
        case .att:
            return Int(CS_OPT_SYNTAX_ATT.rawValue)
        case .intel:
            return Int(CS_OPT_SYNTAX_INTEL.rawValue)
        case .noregname:
            return Int(CS_OPT_SYNTAX_NOREGNAME.rawValue)
        }
    }

}

