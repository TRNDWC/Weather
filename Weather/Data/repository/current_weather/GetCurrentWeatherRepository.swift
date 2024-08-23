//
//  GetCurrentWeatherRepository.swift
//  Weather
//
//  Created by Trần Đức on 14/8/24.
//

import Foundation
import Combine

protocol GetCurrentWeatherRepository {
    func getCurrentWeather (_ locationModel: LocationModel) -> AnyPublisher<CurrentWeatherModel, GetCurrentWeatherRepositoryError>
}

final class GetCurrentWeatherDataStore : GetCurrentWeatherRepository {
    func getCurrentWeather(_ locationModel: LocationModel) -> AnyPublisher<CurrentWeatherModel, GetCurrentWeatherRepositoryError> {
        
        let subject = PassthroughSubject<CurrentWeatherModel, GetCurrentWeatherRepositoryError>()

        let urlString = NetworkConstant.shared.weatherBaseUrl
        
        var queryItems = [
            URLQueryItem(name: "latitude", value: locationModel.latitude),
            URLQueryItem(name: "longitude", value: locationModel.longitude),
            URLQueryItem(name: "current", value: "temperature_2m,relative_humidity_2m,precipitation,weather_code,surface_pressure,wind_speed_10m"),
            URLQueryItem(name: "timezone", value: "auto")
        ]
        
        let unit = UnitProvider.shared.unitModel
        if (unit.tempUnit != TempUnit.c){
            queryItems.append(URLQueryItem(name: "temperature_unit", value: unit.tempUnit.request))
        }
        if (unit.windUnit != WindUnit.km){
            queryItems.append(URLQueryItem(name: "wind_speed_unit", value: unit.windUnit.request))
        }
        
        var urlComps = URLComponents(string: urlString)
        urlComps?.queryItems = queryItems
        
        guard let url = urlComps?.url else {
            subject.send(completion: .failure(.requestError))
            return subject.eraseToAnyPublisher()
        }

        URLSession.shared.dataTask(with: url) { dataResponse, urResponse, error in
            if error == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(CurrentWeatherEntity.self,
                    from: data) {
//                print(url)
                subject.send(resultData.translate)
                subject.send(completion: .finished)
            } else {
                subject.send(completion: .failure(.unknownError))
            }
        }.resume()
        
        return subject.eraseToAnyPublisher()
    }
}
