//
//  HistoryClearInteractorImpl.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/15/24.
//

class HistoryClearInteractorImpl: HistoryClearInteractor {
    private var repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func process() async {
        await repository.clearHistory()
    }
}
