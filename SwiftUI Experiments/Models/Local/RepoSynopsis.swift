//
//  RepoSynopsis.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/7/24.
//

import RealmSwift

class RepoSynopsis: Projection<RepoDetails>, ObjectKeyIdentifiable {
    @Projected(\RepoDetails.id) var id
    @Projected(\RepoDetails.name) var name
    @Projected(\RepoDetails.repoDescription) var repoDescription
    @Projected(\RepoDetails.watchersCount) var watchersCount
    @Projected(\RepoDetails.forksCount) var forksCount
}
