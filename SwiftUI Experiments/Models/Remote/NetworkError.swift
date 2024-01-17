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
            return Strings.DECODING_ERROR
        case .errorCode(let code):
            return Strings.CODE_ERROR(code)
        case .unknown:
            return Strings.UNKNOWN_ERROR
        }
    }
}
