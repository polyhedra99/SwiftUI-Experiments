//
//  RepoLocalSource.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/7/24.
//

protocol RepoLocalSource {
    func saveRepos(repos: [RepoResponseItem], forQuery: String) async
    
    func cleanStaleData(stalePreserved: Int) async
    
    func saveQueryToHistory(query: String) async
    
    func clearHistory() async
}
