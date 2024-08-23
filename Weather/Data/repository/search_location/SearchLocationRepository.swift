//
//  SearchLocationRepository.swift
//  Weather
//
//  Created by Trần Đức on 15/8/24.
//

import Foundation
import Combine

protocol SearchLocationRepository {
    func searchLocation (_ keyword: String) -> AnyPublisher<[LocationModel], SearchLocationRepositoryError>
}

class SearchLocationDataStore : SearchLocationRepository {
    func searchLocation(_ keyword: String) -> AnyPublisher<[LocationModel], SearchLocationRepositoryError>{
        Deferred {
            Future { promise in
                let urlString = NetworkConstant.shared.searchLocationBaseUrl
                let queryItems = [URLQueryItem(name: "q", value: keyword), URLQueryItem(name: "format", value: "json")]
                var urlComps = URLComponents(string: urlString)
                urlComps?.queryItems = queryItems
                
                guard let url = urlComps?.url else {
                    promise(.failure(.requestError))
                    return
                }
                
                URLSession.shared.dataTask(with: url) { dataResponse, urResponse, error in
                    if error == nil,
                       let data = dataResponse,
                       let resultData = try? JSONDecoder().decode([LocationEntity].self,
                            from: data) {
                        promise(.success(resultData.map { LocationModel(from: $0) }))
                    } else {
                        promise(.failure(.unknownError))
                    }
                }.resume()
            }
        }.eraseToAnyPublisher()
    }
}
