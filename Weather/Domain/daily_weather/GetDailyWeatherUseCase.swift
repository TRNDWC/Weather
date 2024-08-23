//
//  GetDailyWeatherUseCase.swift
//  Weather
//
//  Created by Trần Đức on 16/8/24.
//

import Foundation
import Combine

protocol GetDailyWeatherUseCase : UseCase
where Input == LocationModel,
      Output == DailyForecastModel,
      Failure == GetDailyWeatherUseCaseError {}


class GetDailyWeather : GetDailyWeatherUseCase {
    
    private let getDailyWeather : GetDailyWeatherRepository
    
    init(getDailyWeather: GetDailyWeatherRepository) {
        self.getDailyWeather = getDailyWeather
    }
    
    func execute(_ input: LocationModel) -> AnyPublisher<DailyForecastModel, GetDailyWeatherUseCaseError> {
        getDailyWeather.getDailyWeather(input).mapError {
            GetDailyWeatherUseCaseError(repositoryError: $0)
        }.eraseToAnyPublisher()
    }
}
