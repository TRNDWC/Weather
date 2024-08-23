//
//  UseCase.swift
//  Weather
//
//  Created by Trần Đức on 14/8/24.
//

import Foundation
import Combine

protocol UseCase : AnyObject{
    associatedtype Input
    associatedtype Output
    associatedtype Failure : UseCaseError
    
//    var cancellables: Set<AnyCancellable> { get set }
    
    func execute(_ input: Input) -> AnyPublisher<Output, Failure>
    
//    func execute ( _ input: Input, completion: ( (Result<Output, Failure>) -> Void)? )
}
