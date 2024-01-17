//
//  ReposView.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/8/24.
//

import SwiftUI
import RealmSwift
import SimpleToast

struct ReposView: View {
    private var repoUpdateInteractor = Resolver.shared.resolve(RepoUpdateInteractor.self)
    
    @State private var showingToast: Bool = false
    @State private var toastMessage: String = ""
    private let toastOptions = SimpleToastOptions(alignment: .bottom, hideAfter: 3)
    
    @State private var debouncedSearchText: String = ""
    
    @ObservedResults(RepoSynopsis.self) var repos
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack {
                    SearchWithDebounceView(
                        debouncedText: $debouncedSearchText,
                        placeholder: "Search GitHub.."
                    ).padding(.top, 8)
                    ForEach(repos) { repo in
                        NavigationLink(destination: RepoDetailView(id: repo.id)) {
                            RepoSynopsisView(synopsis: repo)
                                .padding(.vertical, 4.0)
                        }.buttonStyle(.plain)
                    }
                }
                .padding()
            }
        }
        .task {
            if let optionalError = await repoUpdateInteractor.process() {
                toastMessage = optionalError.localizedDescription
                showingToast = true
                Logger.error(caller: self, msg: "Error occured: \(optionalError.localizedDescription)")
            } else {
                Logger.info(caller: self, msg: "No error.")
            }
        }
        .simpleToast(isPresented: $showingToast, options: toastOptions) {
            Label(toastMessage, systemImage: "exclamationmark.triangle")
                .padding()
        }
    }
}
