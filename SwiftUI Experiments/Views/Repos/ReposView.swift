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
    @EnvironmentObject var toastData: ToastData
    @EnvironmentObject var drawerData: DrawerData
    
    @AppStorage(Strings.APP_STORAGE_PER_PAGE) var perPage = UniversalConstants.DEFAULT_PER_PAGE
    @AppStorage(Strings.APP_STORAGE_CACHED) var cached = UniversalConstants.DEFAULT_CACHED
    
    private var repoUpdateInteractor = Resolver.shared.resolve(RepoUpdateInteractor.self)
    
    @State private var query: String = ""
    @State private var validationError: String? = nil
    
    @State private var isLoading: Bool = false
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                SearchWithDebounceView(
                    placeholder: Strings.REPOS_SEARCH_PLACEHOLDER,
                    onDebouncedChange: { onSearchChange(query: $0) }
                )
                if let validationError = self.validationError {
                    ErrorTextView(error: validationError)
                }
                
                CircularProgressView(isLoading: $isLoading)
                
                ReposListForQuery(query: $query)
            }
            .navigationTitle(Strings.REPOS_TITLE)
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
        .toolbar {
            LeftDrawerToolbarItem(isDrawerPresented: $drawerData.isDrawerPresented)
        }
    }
    
    private struct ReposListForQuery: View {
        @Binding var query: String
        
        @ObservedResults(
            RepoSynopsis.self
        ) var unfilteredRepos
        
        var body: some View {
            ForEach(unfilteredRepos.filter {
                $0.query == query.lowercased()
            }) { repo in
                NavigationLink(destination: RepoDetailView(id: repo.id)) {
                    RepoSynopsisView(synopsis: repo)
                        .padding(.vertical, 4.0)
                }.buttonStyle(.plain)
            }
            .animation(.easeInOut, value: unfilteredRepos)
        }
    }
    
    private func onSearchChange(query: String) {
        Task {
            self.query = query
            self.validationError = nil
            isLoading = true
            if let sideEffect = await repoUpdateInteractor.process(query: query, perPage: perPage, stalePreserved: cached) {
                switch sideEffect {
                case .networkError(reason: let errorReason):
                    toastData.toastMessage = errorReason
                case .validationFailure(reason: let errorReason):
                    self.validationError = errorReason
                }
            }
            isLoading = false
        }
    }
}
