//
//  NetworkConstant.swift
//  Weather
//
//  Created by Trần Đức on 14/8/24.
//

import Foundation

enum NetworkError : Error{
    case canNotParse
    case urlError
}

class NetworkConstant {
    
    public static let shared: NetworkConstant = NetworkConstant()
    
    private init() {
//        singleton
    }
    
    public var weatherBaseUrl : String {
        get {
            return "https://api.open-meteo.com/v1/forecast"
        }
    }
    
    public var searchLocationBaseUrl : String {
        get {
            return "https://nominatim.openstreetmap.org/search"
        }
    }
    
    
}
