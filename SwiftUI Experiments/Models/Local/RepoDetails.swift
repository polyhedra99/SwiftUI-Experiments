//
//  RepoDetails.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/7/24.
//

import RealmSwift

class RepoDetails: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String? = nil
    @Persisted var fullName: String? = nil
    @Persisted var htmlUrl: String? = nil
    @Persisted var repoDescription: String? = nil
    @Persisted var watchersCount: Int? = nil
    @Persisted var forksCount: Int? = nil
}
