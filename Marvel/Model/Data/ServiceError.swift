//
//  ServiceError.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import Foundation

enum ServiceError: Error {
    case requestError
    case fooError
}

extension ServiceError: Equatable {
    
}
