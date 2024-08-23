//
//  HourlyModel.swift
//  Weather
//
//  Created by Trần Đức on 16/8/24.
//

import Foundation

struct HourlyForecastEntity: Codable {
    let latitude, longitude: Double
    let generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone, timezoneAbbreviation: String
    let elevation: Double
    let hourlyUnits: HourlyUnits
    let hourly: HourlyData

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case hourlyUnits = "hourly_units"
        case hourly
    }
    
    var translate : HourlyForecastModel {
        get {
            return HourlyForecastModel(hourlyUnits: self.hourlyUnits, hourly: self.hourly)
        }
    }
}

struct HourlyUnits: Codable {
    let time, temperature2M, rain, weatherCode: String

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case rain = "precipitation_probability"
        case weatherCode = "weather_code"
    }
}

struct HourlyData: Codable {
    let time: [String]
    let temperature2M: [Double]
    let rain: [Double]
    let weatherCode : [Int]

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case rain = "precipitation_probability"
        case weatherCode = "weather_code"
    }
}


class HourlyForecastModel {
    let hourlyUnits: HourlyUnits
    let hourly: HourlyData
    
    init(hourlyUnits: HourlyUnits, hourly: HourlyData) {
        self.hourlyUnits = hourlyUnits
        self.hourly = hourly
    }
}
