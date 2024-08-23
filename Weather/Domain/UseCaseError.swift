//
//  UseCaseError.swift
//  Weather
//
//  Created by Trần Đức on 14/8/24.
//

import Foundation

protocol UseCaseError: Error {
    var message: String { get }
}
