//
//  Repository.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/7/24.
//

// Would be more repositories for more models
protocol Repository {
    func fetchRepos(query: String, perPage: Int) async -> ([RepoResponseItem]?, NetworkError?)
    func saveRepos(repos: [RepoResponseItem], forQuery: String) async
    func cleanStaleReposData(stalePreserved: Int) async
    func saveQueryToHistory(query: String) async
    func clearHistory() async
}
