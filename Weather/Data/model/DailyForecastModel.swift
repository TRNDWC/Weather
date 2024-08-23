//
//  DailyForecastModel.swift
//  Weather
//
//  Created by Trần Đức on 16/8/24.
//

import Foundation

class DailyForecastEntity: Codable {
    let latitude: Double
    let longitude: Double
    let generationtimeMs: Double
    let utcOffsetSeconds: Int
    let timezone: String
    let timezoneAbbreviation: String
    let elevation: Double
    let dailyUnits: DailyUnits
    let daily: DailyData
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case generationtimeMs = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case dailyUnits = "daily_units"
        case daily
    }
    
    var translate : DailyForecastModel {
        get {
            return DailyForecastModel(dailyUnits: self.dailyUnits, daily: self.daily)
        }
    }
}

struct DailyUnits: Codable {
    let time: String
    let weatherCode: String
    let temperature2mMax: String
    let temperature2mMin: String
    let rainSum: String
    
    enum CodingKeys: String, CodingKey {
        case time
        case weatherCode = "weather_code"
        case temperature2mMax = "temperature_2m_max"
        case temperature2mMin = "temperature_2m_min"
        case rainSum = "precipitation_probability_max"
    }
}

struct DailyData: Codable {
    let time: [String]
    let weatherCode: [Int]
    let temperature2mMax: [Double]
    let temperature2mMin: [Double]
    let rainSum: [Double]
    
    enum CodingKeys: String, CodingKey {
        case time
        case weatherCode = "weather_code"
        case temperature2mMax = "temperature_2m_max"
        case temperature2mMin = "temperature_2m_min"
        case rainSum = "precipitation_probability_max"
    }
}

class DailyForecastModel {
    let dailyUnits: DailyUnits
    let daily: DailyData
    
    init(dailyUnits: DailyUnits, daily: DailyData) {
        self.dailyUnits = dailyUnits
        self.daily = daily
    }
}
