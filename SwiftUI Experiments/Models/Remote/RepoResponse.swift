//
//  RepoResponse.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/7/24.
//

struct RepoResponse: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [RepoResponseItem]?
}

struct RepoResponseItem: Codable {
    let id: Int?
    let name: String?
    let fullName: String?
    let htmlUrl: String?
    let description: String?
    let watchersCount: Int?
    let forksCount: Int?
}
