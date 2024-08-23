//
//  SearchLocationRepositoryError.swift
//  Weather
//
//  Created by Trần Đức on 15/8/24.
//

import Foundation

enum SearchLocationRepositoryError : RepositoryError {
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
}
