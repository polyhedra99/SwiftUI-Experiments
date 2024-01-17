//
//  RepoRemoteSourceImpl.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/7/24.
//

import Foundation
import Combine

class RepoRemoteSourceImpl: RepoRemoteSource {
    let session: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.session = urlSession
    }
    
    // Not scalable, yet sufficient for the scope of the project
    func fetchRepos(query: String, perPage: Int) async -> ([RepoResponseItem]?, NetworkError?) {
        Logger.info(caller: self, msg: "fetchRepos() called.")
        let urlString = "https://api.github.com/search/repositories?q=\(query)&per_page=\(perPage)"
        Logger.info(caller: self, msg: "URL string to call: \(urlString)")
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        
        if let result = try? await session.data(from: url) {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase
            if let decoded = try? decoder.decode(RepoResponse.self, from: result.0) {
                return (decoded.items, nil)
            } else {
                return (nil, NetworkError.decodingError)
            }
        } else {
            return (nil, NetworkError.unknown)
        }
    }
}
