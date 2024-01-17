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
    
    func process(query: String) async -> ReposSideEffect? {
        if (query.isEmpty) {
            return nil
        // Pseudo-validation for demonstrational purposes
        } else if (query.contains("~")) {
            return ReposSideEffect.validationFailure(reason: Strings.REPOS_CONTAINS_TILDA)
        } else {
            return await repository.updateRepos(query: query.lowercased()).map { error in
                ReposSideEffect.networkError(reason: error.localizedDescription)
            }
        }
    }
}
