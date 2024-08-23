//
//  WeatherModel.swift
//  Weather
//
//  Created by Trần Đức on 19/8/24.
//

import Foundation

class WeatherModel {
    var location : LocationModel
    var current : CurrentWeatherModel
    var hourly : HourlyForecastModel
    var daily : DailyForecastModel
    
    init(location: LocationModel, current: CurrentWeatherModel, hourly: HourlyForecastModel, daily: DailyForecastModel) {
        self.location = location
        self.current = current
        self.hourly = hourly
        self.daily = daily
    }
    
    func getDisplayModel(unitModel: UnitModel) -> WeatherModel {
        func convertPressure(from hPa: Double, to unit: String) -> Double {
            switch unit {
            case "mbar":
                return hPa // 1 hPa = 1 mbar
            case "mmHg":
                return hPa * 0.750062
            case "atm":
                return hPa * 0.000986923
            case "inHg":
                return hPa * 0.02953
            default:
                return hPa // Default case (no conversion)
            }
        }
        
        let convertedPressure = convertPressure(from: self.current.currentWeather.surfacePressure, to: unitModel.pressureUnit.title)
        
        let newCurrentWeather = CurrentWeather(
            time: self.current.currentWeather.time,
            interval: self.current.currentWeather.interval,
            temperature2m: self.current.currentWeather.temperature2m, // Convert if necessary
            relativeHumidity2m: self.current.currentWeather.relativeHumidity2m,
            rain: self.current.currentWeather.rain,
            weatherCode: self.current.currentWeather.weatherCode,
            surfacePressure: convertedPressure,
            windSpeed10m: self.current.currentWeather.windSpeed10m // Convert if necessary
        )
        
        let newWeatherModel = WeatherModel(
            location: self.location,
            current: CurrentWeatherModel(currentWeather: newCurrentWeather, currentUnits: self.current.currentUnits),
            hourly: self.hourly,
            daily: self.daily
        )
        
        return newWeatherModel
    }
}
