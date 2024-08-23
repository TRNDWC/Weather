//
//  Setting.swift
//  Weather
//
//  Created by Trần Đức on 14/8/24.
//

import Foundation

enum TempUnit : Equatable {
    case c
    case f
    
    var title: String {
        switch self {
        case.c : return "°C"
        case.f : return "°F"
        }
    }
    
    var request: String{
        switch self {
        case.c : return "°C"
        case.f : return "fahrenheit"
        }
    }
    
    init?(title: String) {
        switch title {
        case "°C":
            self = .c
        case "°F":
            self = .f
        default:
            return nil
        }
    }
    
    static func ==(lhs: TempUnit, rhs: TempUnit) -> Bool {
        return lhs.title == rhs.title
    }
}

enum WindUnit : Equatable {
    case km
    case mil
    case m
    case kn
    
    var title: String {
        switch self {
        case.km : return "km/h"
        case.mil : return "mil/h"
        case.m : return "m/s"
        case.kn : return "kn"
        }
    }
    
    var request: String {
        switch self {
        case.km : return ""
        case.mil : return "mph"
        case.m : return "ms"
        case.kn : return "kn"
        }
    }
    
    init?(title: String) {
        switch title {
        case "km/h":
            self = .km
        case "mil/h":
            self = .mil
        case "m/s":
            self = .m
        case "kn":
            self = .kn
        default:
            return nil
        }
    }
    static func ==(lhs: WindUnit, rhs: WindUnit) -> Bool {
        return lhs.title == rhs.title
    }
}

enum AtmosUnit : Equatable {
    case mbar
    case atm
    case mmHg
    case inHg
    case hPa
    
    var title: String {
        switch self {
        case.mbar : return "mbar"
        case.atm : return "atm"
        case.mmHg : return "mmHg"
        case.inHg : return "inHg"
        case.hPa : return "hPa"
        }
    }
    init?(title: String) {
        switch title {
        case "mbar":
            self = .mbar
        case "atm":
            self = .atm
        case "mmHg":
            self = .mmHg
        case "inHg":
            self = .inHg
        case "hPa":
            self = .hPa
        default:
            return nil
        }
    }
    static func ==(lhs: AtmosUnit, rhs: AtmosUnit) -> Bool {
        return lhs.title == rhs.title
    }
}
