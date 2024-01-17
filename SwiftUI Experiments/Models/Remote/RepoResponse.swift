//
//  RepoListResponse.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/7/24.
//

struct RepoResponse: Codable, CustomStringConvertible {
    let title: String
    let body: String
    
    public var description: String {
        "RepoListReponse(\(title): \(body))"
    }
}
