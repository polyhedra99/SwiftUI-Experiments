//
//  StringExtensions.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/10/24.
//

extension String {
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}
