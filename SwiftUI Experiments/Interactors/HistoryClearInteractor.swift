//
//  HistoryClearInteractor.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/15/24.
//

// Theoretically, it would be nice to unify Interactor with some base protocol, but I don't feel like it makes for this project
protocol HistoryClearInteractor {
    func process() async -> Void
}
