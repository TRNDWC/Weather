//
//  WeatherProvider.swift
//  Weather
//
//  Created by Trần Đức on 19/8/24.
//

import Foundation

class WeatherProvider {
    private static var weathers: [WeatherModel] = []

    static func getWeathers() -> [WeatherModel] {
        return weathers
    }

    static func addWeather(_ weather: WeatherModel) {
        if let _ = weathers.first(where: { $0.location == weather.location }) {
            return
        }
        weathers.append(weather)
    }

    static func removeWeather(at index: Int) {
        guard index >= 0 && index < weathers.count else { return }
        weathers.remove(at: index)
    }

    static func updateWeather(at index: Int, with weather: WeatherModel) {
        guard index >= 0 && index < weathers.count else { return }
        weathers[index] = weather
    }

    static func indexOfWeather(for location: LocationModel) -> Int? {
        return weathers.firstIndex { $0.location  == location }
    }
    
    static func fillWeather (_ data : [WeatherModel]){
        weathers = data
    }
}
