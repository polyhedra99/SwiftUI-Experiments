//
//  RepoDetails.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/7/24.
//

import RealmSwift
import Foundation

class RepoDetails: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var query: String
    @Persisted var timestamp: Date
    @Persisted var name: String?
    @Persisted var fullName: String?
    @Persisted var htmlUrl: String?
    @Persisted var repoDescription: String?
    @Persisted var watchersCount: Int?
    @Persisted var forksCount: Int?
    
    convenience init(
        id: Int,
        query: String,
        timestamp: Date,
        name: String?,
        fullName: String?,
        htmlUrl: String?,
        repoDescription: String?,
        watchersCount: Int?,
        forksCount: Int?
    ) {
        self.init()
        self.id = id
        self.timestamp = timestamp
        self.query = query
        self.name = name
        self.fullName = fullName
        self.htmlUrl = htmlUrl
        self.repoDescription = repoDescription
        self.watchersCount = watchersCount
        self.forksCount = forksCount
    }
}
