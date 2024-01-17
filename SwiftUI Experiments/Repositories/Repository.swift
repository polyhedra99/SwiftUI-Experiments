//
//  RepoRepository.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/7/24.
//

protocol Repository {
    // TODO: Error return
    func updateRepos() async -> NetworkError?
}
