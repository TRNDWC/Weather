//
//  GetDailyWeatherUseCaseError.swift
//  Weather
//
//  Created by Trần Đức on 16/8/24.
//

import Foundation

enum GetDailyWeatherUseCaseError : UseCaseError {
    case networkError
    case invalidResponse
    case unknownError
    case requestError

    var message: String {
        switch self {
        case .networkError:
            return "Failed to connect to the network."
        case .invalidResponse:
            return "Received an invalid response."
        case .unknownError:
            return "An unknown error occurred."
        case .requestError:
            return "Bad request"
        }
    }
    
    init(repositoryError: GetDailyWeatherRepositoryError) {
        switch repositoryError {
        case .networkError:
            self = .networkError
        case .invalidResponse:
            self = .invalidResponse
        case.requestError:
            self = .requestError
        case .unknownError:
            self = .unknownError
        }
    }
}
