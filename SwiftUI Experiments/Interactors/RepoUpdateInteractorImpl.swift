//
//  RepoUpdateInteractorImpl.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/8/24.
//

class RepoUpdateInteractorImpl: RepoUpdateInteractor {
    private var repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    // In a bigger project would chain interactors instead
    func process(query: String, perPage: Int, stalePreserved: Int) async -> ReposSideEffect? {
        if (query.isEmpty) {
            return nil
            // Pseudo-validation for demonstrational purposes
        } else if (query.contains("~")) {
            return ReposSideEffect.validationFailure(reason: Strings.REPOS_CONTAINS_TILDA)
        } else {
            await repository.saveQueryToHistory(query: query)
            
            let fetchResult = await repository.fetchRepos(query: query.lowercased(), perPage: perPage)
            if let repos = fetchResult.0 {
                await repository.saveRepos(repos: repos, forQuery: query)
            } else {
                Logger.error(caller: self, msg: "Fetched repos are null.")
            }
            
            await repository.cleanStaleReposData(stalePreserved: stalePreserved)
            
            let optionalError = fetchResult.1.map { error in
                ReposSideEffect.networkError(reason: error.localizedDescription)
            }
            return optionalError
        }
    }
}
