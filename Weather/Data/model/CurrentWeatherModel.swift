//
//  CurrentWeatherModel.swift
//  Weather
//
//  Created by Trần Đức on 14/8/24.
//

import Foundation

struct CurrentUnits : Decodable {
    let time: String
    let interval: String
    let temperature2m: String
    let relativeHumidity2m: String
    let rain: String
    let weatherCode: String
    let surfacePressure: String
    let windSpeed10m: String
    
    enum CodingKeys: String, CodingKey {
        case time
        case interval
        case temperature2m = "temperature_2m"
        case relativeHumidity2m = "relative_humidity_2m"
        case rain = "precipitation"
        case weatherCode = "weather_code"
        case surfacePressure = "surface_pressure"
        case windSpeed10m = "wind_speed_10m"
    }
}

// Define the current weather structure
struct CurrentWeather : Decodable {
    let time: String
    let interval: Int
    let temperature2m: Double
    let relativeHumidity2m: Int
    let rain: Double
    let weatherCode: Int
    let surfacePressure: Double
    let windSpeed10m: Double
    
    enum CodingKeys: String, CodingKey {
        case time
        case interval
        case temperature2m = "temperature_2m"
        case relativeHumidity2m = "relative_humidity_2m"
        case rain = "precipitation"
        case weatherCode = "weather_code"
        case surfacePressure = "surface_pressure"
        case windSpeed10m = "wind_speed_10m"
    }

}

class CurrentWeatherEntity : Decodable{
    let latitude: Double
    let longitude: Double
    let generationTimeMs: Double
    let utcOffsetSeconds: Int
    let timezone: String
    let timezoneAbbreviation: String
    let elevation: Double
    let currentUnits: CurrentUnits
    let current: CurrentWeather
    
    init(latitude: Double,
         longitude: Double,
         generationTimeMs: Double,
         utcOffsetSeconds: Int,
         timezone: String,
         timezoneAbbreviation: String,
         elevation: Double,
         currentUnits: CurrentUnits,
         current: CurrentWeather) {
        self.latitude = latitude
        self.longitude = longitude
        self.generationTimeMs = generationTimeMs
        self.utcOffsetSeconds = utcOffsetSeconds
        self.timezone = timezone
        self.timezoneAbbreviation = timezoneAbbreviation
        self.elevation = elevation
        self.currentUnits = currentUnits
        self.current = current
    }
    
    var translate : CurrentWeatherModel {
        get{
            return CurrentWeatherModel(currentWeather: self.current, currentUnits: self.currentUnits)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case generationTimeMs = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezoneAbbreviation = "timezone_abbreviation"
        case currentUnits = "current_units"
        case latitude
        case longitude
        case timezone
        case elevation
        case current
    }
}


class CurrentWeatherModel {
    var currentWeather: CurrentWeather
    var currentUnits: CurrentUnits
    
    init(currentWeather: CurrentWeather, currentUnits: CurrentUnits) {
        self.currentWeather = currentWeather
        self.currentUnits = currentUnits
    }
}
