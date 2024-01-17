//
//  RepoSynopsisView.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/9/24.
//

import SwiftUI
import RealmSwift

struct RepoSynopsisView: View {
    @ObservedRealmObject var synopsis: RepoSynopsis
    
    var body: some View {
        VStack(spacing: 0.0) {
            VStack {
                Text(synopsis.name ?? ViewConstants.NIL_TEXT_VALUE)
                    .font(.headline)
                Text(synopsis.repoDescription ?? ViewConstants.NIL_TEXT_VALUE)
            }
            .padding()
            
            Divider()
                .overlay(.foreground.opacity(ViewConstants.CARD_STACKED_DIVIDER_OPACITY))
            
            HStack {
                Spacer()
                Label(String(synopsis.watchersCount ?? ViewConstants.NIL_NUMBER_VALUE), systemImage: "eye")
                    .font(.caption)
                    .frame(width: 65, alignment: .leading)
                Label(String(synopsis.forksCount ?? ViewConstants.NIL_NUMBER_VALUE), systemImage: "tuningfork")
                    .font(.caption)
                    .frame(width: 60, alignment: .leading)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(.foreground.opacity(ViewConstants.CARD_STACKED_OPACITY))
        }
        .background(Color(.secondarySystemBackground))
        // I find this method of rounding corners very weird, but not sure of an alternative
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 16.0, height: 1.0)))
    }
}
