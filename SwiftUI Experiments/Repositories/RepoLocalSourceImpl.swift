//
//  RepoLocalSourceImpl.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/7/24.
//

import Foundation
import RealmSwift

class RepoLocalSourceImpl: RepoLocalSource {
    private var realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func saveRepos(repos: [RepoResponseItem], forQuery: String) async {
        Logger.info(caller: self, msg: "saveRepos() called.")
        // Mapper could be separated, but it's not really essential here
        let timestamp = Date()
        let mapped = repos
            .filter { $0.id != nil }
            .map { remote in
                RepoDetails(
                    id: remote.id!,
                    query: forQuery.lowercased(),
                    timestamp: timestamp,
                    name: remote.name,
                    fullName: remote.fullName,
                    htmlUrl: remote.htmlUrl,
                    repoDescription: remote.description,
                    watchersCount: remote.watchersCount,
                    forksCount: remote.forksCount
                )
            }
        DispatchQueue.main.async { [self] in
            try! realm.write {
                realm.add(mapped, update: .all)
            }
        }
    }
    
    // Obviously this is a bit overcomplicated, no lag detected. Would be simpler for daily removal, but since I decided to keep a set amount of results insted, here it goes.
    func cleanStaleData(stalePreserved: Int) async {
        Logger.info(caller: self, msg: "cleanStaleData() called.")
        DispatchQueue.main.async { [self] in
            let detailsItems = realm.objects(RepoDetails.self)
            let sortedTimestamps = Array(detailsItems.sectioned(by: \.timestamp).allKeys.sorted().reversed().prefix(stalePreserved))
            let itemsToRemove = detailsItems.filter { !sortedTimestamps.contains($0.timestamp) }
            try! realm.write {
                realm.delete(itemsToRemove)
            }
        }
    }
    
    func saveQueryToHistory(query: String) async {
        Logger.info(caller: self, msg: "saveQueryToHistory() called.")
        // More methods and this gets abstracted
        DispatchQueue.main.async { [self] in
            try! realm.write {
                realm.add(HistoryEntry(query: query, timestamp: Date()), update: .all)
            }
        }
    }
    
    func clearHistory() async {
        Logger.info(caller: self, msg: "clearHistory() called.")
        DispatchQueue.main.async { [self] in
            let historyItems = realm.objects(HistoryEntry.self)
            try! realm.write {
                realm.delete(historyItems)
            }
        }
    }
}
