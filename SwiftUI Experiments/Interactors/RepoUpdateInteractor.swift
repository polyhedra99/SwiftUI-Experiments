//
//  RepoUpdateInteractor.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/8/24.
//

protocol RepoUpdateInteractor {
    // One more and parameters get abstracted to a model
    func process(query: String, perPage: Int, stalePreserved: Int) async -> ReposSideEffect?
}
