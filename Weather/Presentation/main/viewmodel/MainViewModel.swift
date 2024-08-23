//
//  MainViewModel.swift
//  Weather
//
//  Created by Trần Đức on 14/8/24.
//

import Foundation
import Combine
 
enum MainState{
    case loading
    case loaded
}

class MainViewModel {
    
    private let current: any GetCurrentWeatherUseCase
    private let hourly: any GetHourlyWeatherUseCase
    private let daily: any GetDailyWeatherUseCase
    private var cancellables = Set<AnyCancellable>()
    @Published var state : MainState = MainState.loaded
    
    init(current: any GetCurrentWeatherUseCase, hourly: any GetHourlyWeatherUseCase, daily: any GetDailyWeatherUseCase) {
        self.current = current
        self.hourly = hourly
        self.daily = daily
    }
    
    
    func fetchWeatherData() {
        
        print ("this called")
        
        state = MainState.loading
        let locations = WeatherProvider.getWeathers().map { $0.location }
        let publishers = locations.map { location in
            fetchWeather(for: location)
        }
        
        Publishers.MergeMany(publishers)
            .collect()
            .sink(receiveCompletion: { [weak self] completion in
                self?.state = MainState.loaded
            }, receiveValue: { weatherDataArray in
                WeatherProvider.fillWeather(weatherDataArray.sorted {$0.location.time ?? Date() < $1.location.time ?? Date()})
            })
            .store(in: &cancellables)
    }
    
    private func fetchWeather(for locationModel: LocationModel) -> AnyPublisher<WeatherModel, Error> {
        
        let currentPublisher = current.execute(locationModel)
            .mapError { $0 as Error }
        
        let hourlyPublisher = hourly.execute(locationModel)
            .mapError { $0 as Error }
        
        let dailyPublisher = daily.execute(locationModel)
            .mapError { $0 as Error }
        
        return currentPublisher
            .combineLatest(hourlyPublisher, dailyPublisher)
            .map { currentWeather, hourlyWeather, dailyWeather in
                return WeatherModel(location: locationModel, current: currentWeather, hourly: hourlyWeather, daily: dailyWeather)
            }
            .eraseToAnyPublisher()
    }
}
