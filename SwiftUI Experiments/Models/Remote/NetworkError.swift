//
//  NetworkError.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/7/24.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Failed to decode the object from the service."
        case .errorCode(let code):
            return "\(code) - error code."
        case .unknown:
            return "Unknown error."
        }
    }
}
