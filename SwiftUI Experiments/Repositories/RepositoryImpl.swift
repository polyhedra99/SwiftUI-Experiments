//
//  RepoRepositoryImpl.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/7/24.
//

import Combine

class RepositoryImpl: Repository {
    private var repoRemoteSource: RepoRemoteSource
    private var repoLocalSource: RepoLocalSource
    
    init(repoRemoteSource: RepoRemoteSource, repoLocalSource: RepoLocalSource) {
        self.repoRemoteSource = repoRemoteSource
        self.repoLocalSource = repoLocalSource
    }
    
    // TODO: Intermediate state of the logic
    func updateRepos() async -> NetworkError? {
        Logger.info(caller: self, msg: "updateRepos() called")
        return await repoRemoteSource.fetchRepos().1
        // repoLocalSource.cleanStaleData()
    }
}
