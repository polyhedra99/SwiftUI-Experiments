//
//  ReposSideEffect.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/10/24.
//

enum ReposSideEffect {
    case validationFailure(reason: String)
    case networkError(reason: String)
}
