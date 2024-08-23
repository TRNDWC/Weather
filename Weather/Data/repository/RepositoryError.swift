//
//  RepositoryError.swift
//  Weather
//
//  Created by Trần Đức on 15/8/24.
//

import Foundation

protocol RepositoryError: Error {
    var message: String { get }
}
