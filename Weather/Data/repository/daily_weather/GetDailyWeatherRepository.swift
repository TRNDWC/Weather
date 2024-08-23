//
//  GetDailyWeatherRepository.swift
//  Weather
//
//  Created by Trần Đức on 16/8/24.
//

import Foundation
import Combine

protocol GetDailyWeatherRepository {
    func getDailyWeather ( _ locationModel :  LocationModel) -> AnyPublisher <DailyForecastModel, GetDailyWeatherRepositoryError>
}


class GetDailyWeatherDataStore : GetDailyWeatherRepository {
    func getDailyWeather(_ locationModel: LocationModel) -> AnyPublisher<DailyForecastModel, GetDailyWeatherRepositoryError> {
        Deferred {
            Future { promise in        
                let urlString = NetworkConstant.shared.weatherBaseUrl
        
                var queryItems = [
                    URLQueryItem(name: "latitude", value: locationModel.latitude),
                    URLQueryItem(name: "longitude", value: locationModel.longitude),
                    URLQueryItem(name: "daily", value: "weather_code,temperature_2m_max,temperature_2m_min,precipitation_probability_max"),
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
                    promise(.failure(.requestError))
                    return
                }
                                
                URLSession.shared.dataTask(with: url) { dataResponse, urResponse, error in
                    if error == nil,
                       let data = dataResponse,
                       let resultData = try? JSONDecoder().decode(DailyForecastEntity.self,
                            from: data) {
                        promise(.success(resultData.translate))
                    } else {
                        promise(.failure(.unknownError))
                    }
                }.resume()
            }
        }.eraseToAnyPublisher()
    }
}
