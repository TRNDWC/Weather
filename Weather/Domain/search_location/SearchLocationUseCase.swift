//
//  SearchLocationUseCase.swift
//  Weather
//
//  Created by Trần Đức on 15/8/24.
//

import Foundation
import Combine

protocol SearchLocationUseCase : UseCase
where Input == String,
      Output == [LocationModel],
      Failure == SearchLocationUseCaseError{}

class SearchLocation : SearchLocationUseCase {
    
    private let searchLocation : SearchLocationRepository
    
    init(searchLocation: SearchLocationRepository) {
        self.searchLocation = searchLocation
    }
    
    func execute(_ input: String) -> AnyPublisher<Array<LocationModel>, SearchLocationUseCaseError> {
        searchLocation.searchLocation(input).mapError {
            SearchLocationUseCaseError(repositoryError: $0)
        }.eraseToAnyPublisher()
    }
}
