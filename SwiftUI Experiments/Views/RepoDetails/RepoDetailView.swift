//
//  RepoDetailView.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/8/24.
//

import SwiftUI
import RealmSwift

struct RepoDetailView: View {
    private var id: ObjectId
    
    init(id: ObjectId) {
        self.id = id
    }
    
    var body: some View {
        @ObservedResults(
            RepoDetails.self,
            where: { $0.id == id }
        ) var queryResults
        let details = queryResults.first
        
        VStack(spacing: 0.0) {
            VStack {
                Text(details?.name ?? "-")
                    .font(.headline)
                Text(details?.fullName ?? "-")
                    .font(.subheadline)
            }.padding()
            
            // TODO: Make reusable from synopsis
            Divider()
                .overlay(.foreground.opacity(0.3))
            
            VStack(alignment: .leading) {
                if let url = URL(string: details?.htmlUrl ?? "") {
                    Link(destination: url) {
                        Text("\(url)")
                            .font(.footnote)
                    }
                }
                Text(details?.repoDescription ?? "-")
                    .padding(.vertical, 8)
                Text("Watchers: \(details?.watchersCount ?? -1)")
                Text("Forks: \(details?.forksCount ?? -1)")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.foreground.opacity(0.1))
        }
        .background(.foreground.opacity(0.15))
        // I find this method of rounding corners very weird, but not sure of an alternative
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 16.0, height: 1.0)))
        
        Spacer()
    }
}
