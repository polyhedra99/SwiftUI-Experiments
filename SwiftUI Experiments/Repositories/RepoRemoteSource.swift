//
//  RepoRemoteSource.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/7/24.
//

import Combine

protocol RepoRemoteSource {
    func fetchRepos(query: String, perPage: Int) async -> ([RepoResponseItem]?, NetworkError?)
}
