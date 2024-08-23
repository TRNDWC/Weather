//
//  GetForecastHourlyUseCase.swift
//  Weather
//
//  Created by Trần Đức on 16/8/24.
//

import Foundation
import Combine

protocol GetHourlyWeatherUseCase : UseCase
where Input == LocationModel,
      Output == HourlyForecastModel,
      Failure == GetForecastHourlyUseCaseError {}

class GetForecastHourly : GetHourlyWeatherUseCase {
    
    private let getHourly : GetForecastHourlyRepository
    
    init(getHourly: GetForecastHourlyRepository) {
        self.getHourly = getHourly
    }
    
    func execute(_ input: LocationModel) -> AnyPublisher<HourlyForecastModel, GetForecastHourlyUseCaseError> {
        getHourly.getHourlyForecast(input).mapError{
            GetForecastHourlyUseCaseError(repositoryError: $0)
        }.eraseToAnyPublisher()
    }
}

