//
//  SearchViewModel.swift
//  Weather
//
//  Created by Trần Đức on 15/8/24.
//

import Foundation
import Combine

struct User {
   let name: CurrentValueSubject<String, Never>
}

class SearchViewModel {
    
    private let searchLocation: any SearchLocationUseCase
    private let current: any GetCurrentWeatherUseCase
    private let hourly: any GetHourlyWeatherUseCase
    private let daily: any GetDailyWeatherUseCase
    
    @Published var locations : [LocationModel] = []
    @Published var currentWeather : CurrentWeatherModel?
    @Published var hourlyWeather : HourlyForecastModel?
    @Published var dailyWeather : DailyForecastModel?
    
    private let keyword = PassthroughSubject<String, Never>()
    private var cancellables: [AnyCancellable] = []

    func emitKeyword(_ value: String) {
        keyword.send(value)
    }
        
    init(searchLocation: any SearchLocationUseCase, current: any GetCurrentWeatherUseCase, hourly: any GetHourlyWeatherUseCase, daily: any GetDailyWeatherUseCase) {
        self.searchLocation = searchLocation
        self.current = current
        self.hourly = hourly
        self.daily = daily
        
        setupBindings()
    }
    
    private func setupBindings() {
        keyword
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .map { [weak self] keyword in
                self?.searchLocation.execute(keyword).convertToResultPublisher() ?? Empty().eraseToAnyPublisher()
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .success(let data):
                    self?.locations = data
                    
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
            .store(in: &cancellables)
    }
    
    func getCurrent (locationModel : LocationModel){
        current.execute(locationModel)
            .convertToResultPublisher()
            .sink { [weak self] result in
                switch result{
                case .success(let data):
                    self?.currentWeather = data
                case .failure(let error):
                    print("Error getCurrent: \(error)")
                }
            }.store(in: &cancellables)
    }
    
    func getHourly (locationModel : LocationModel){
        hourly.execute(locationModel)
            .convertToResultPublisher()
            .sink { [weak self] result in
                switch result{
                case .success(let data):
                    self?.hourlyWeather = data
                case .failure(let error):
                    print("Error getHourly: \(error)")
                }
            }.store(in: &cancellables)
    }
    
    func getDaily (locationModel : LocationModel){
        daily.execute(locationModel)
            .convertToResultPublisher()
            .sink { [weak self] result in
                switch result{
                case .success(let data):
                    self?.dailyWeather = data
                case .failure(let error):
                    print("Error getDaily: \(error)")
                }
            }.store(in: &cancellables)
    }
}

