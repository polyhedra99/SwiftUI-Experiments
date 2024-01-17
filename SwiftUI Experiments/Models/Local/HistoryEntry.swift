//
//  HistoryEntry.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/15/24.
//

import RealmSwift
import Foundation

class HistoryEntry: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var query: String
    @Persisted var timestamp: Date
    
    convenience init(query: String) {
        self.init()
        self.query = query
        self.timestamp = Date()
    }
}
