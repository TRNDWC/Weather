//
//  PublisherExtension.swift
//  Weather
//
//  Created by Trần Đức on 15/8/24.
//

import Foundation
import Combine

extension Publisher{
    func convertToResultPublisher() -> AnyPublisher<Result<Output,Failure>, Never>{
        self.map{
            .success($0)
        }.catch{
            Just(.failure($0))
        }.eraseToAnyPublisher()
    }
}
