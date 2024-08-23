//
//  CurrentWeatherUseCase.swift
//  Weather
//
//  Created by Trần Đức on 14/8/24.
//

import Foundation
import Combine

protocol GetCurrentWeatherUseCase : UseCase
where Input == LocationModel,
      Output == CurrentWeatherModel,
      Failure == GetCurrentWeatherUseCaseError {}

final class GetCurrentWeather : GetCurrentWeatherUseCase {
    private let getCurrentWeather : GetCurrentWeatherRepository
    
    init(getCurrentWeather: GetCurrentWeatherRepository) {
        self.getCurrentWeather = getCurrentWeather
    }
    
    func execute(_ input: LocationModel) -> AnyPublisher<CurrentWeatherModel, GetCurrentWeatherUseCaseError> {
        return getCurrentWeather.getCurrentWeather(input).mapError{ repositoryError in
            return GetCurrentWeatherUseCaseError(repositoryError: repositoryError)
        }.eraseToAnyPublisher()
    }
}
