//
//  RepositoryImpl.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/7/24.
//

class RepositoryImpl: Repository {
    private var repoRemoteSource: RepoRemoteSource
    private var repoLocalSource: RepoLocalSource
    
    init(repoRemoteSource: RepoRemoteSource, repoLocalSource: RepoLocalSource) {
        self.repoRemoteSource = repoRemoteSource
        self.repoLocalSource = repoLocalSource
    }
    
    func fetchRepos(query: String, perPage: Int) async -> ([RepoResponseItem]?, NetworkError?) {
        Logger.info(caller: self, msg: "fetchRepos() called")
        return await repoRemoteSource.fetchRepos(query: query, perPage: perPage)
    }
    
    func saveRepos(repos: [RepoResponseItem], forQuery: String) async {
        Logger.info(caller: self, msg: "saveRepos() called")
        await repoLocalSource.saveRepos(repos: repos, forQuery: forQuery)
    }
    
    func cleanStaleReposData(stalePreserved: Int) async {
        Logger.info(caller: self, msg: "cleanStaleReposData() called")
        await repoLocalSource.cleanStaleData(stalePreserved: stalePreserved)
    }
    
    func saveQueryToHistory(query: String) async {
        Logger.info(caller: self, msg: "saveQueryToHistory() called")
        await repoLocalSource.saveQueryToHistory(query: query)
    }
    
    func clearHistory() async {
        Logger.info(caller: self, msg: "clearHistory() called")
        await repoLocalSource.clearHistory()
    }
}
