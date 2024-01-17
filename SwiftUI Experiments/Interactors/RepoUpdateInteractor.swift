//
//  RepoUpdateInteractor.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/8/24.
//

protocol RepoUpdateInteractor {
    func process(query: String) async -> ReposSideEffect?
}
