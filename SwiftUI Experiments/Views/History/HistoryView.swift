//
//  HistoryView.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/13/24.
//

import SwiftUI
import RealmSwift

struct HistoryView: View {
    @EnvironmentObject var toastData: ToastData
    @EnvironmentObject var drawerData: DrawerData
    
    private var historyClearInteractor = Resolver.shared.resolve(HistoryClearInteractor.self)
    
    @ObservedResults(
        HistoryEntry.self,
        sortDescriptor: SortDescriptor(keyPath: "timestamp", ascending: false)
    ) var historyEntries
    
    var body: some View {
        List(historyEntries) { entry in
            HistoryItem(entry: entry)
        }
        .overlay {
            Group {
                if historyEntries.isEmpty {
                    Text("History is empty")
                }
            }
        }
        .padding(.top, 8)
        .listStyle(.plain)
        .navigationTitle(Strings.HISTORY_TITLE)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            LeftDrawerToolbarItem(isDrawerPresented: $drawerData.isDrawerPresented)
        }
        .toolbar {
            Button {
                Task {
                    await historyClearInteractor.process()
                    // Unchecked success, but works fine for the scale of this project
                    toastData.toastMessage = Strings.HISTORY_CLEAR_SUCCESS
                }
            } label: {
                Text(Strings.HISTORY_CLEAR)
            }
        }
    }
    
    @ViewBuilder
    private func HistoryItem(entry: HistoryEntry) -> some View {
        let formatter = constructDateFormatter()
        
        HStack {
            Text(entry.query).bold()
            Spacer()
            Text(formatter.string(from: entry.timestamp)).font(.callout)
        }.padding(4)
    }
    
    private func constructDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
