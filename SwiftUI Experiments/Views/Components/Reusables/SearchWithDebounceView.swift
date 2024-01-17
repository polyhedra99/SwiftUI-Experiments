//
//  SearchWithDebounceView.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/9/24.
//

import SwiftUI
import Combine

struct SearchWithDebounceView: View {
    @StateObject private var textObserver = TextFieldObserver()
    @State var showClearButton = false
    var placeholder = "Search"
    var onDebouncedChange: (String) -> ()
    
    var body: some View {
        TextField(
            placeholder,
            text: $textObserver.searchText,
            onEditingChanged: { editing in
                self.showClearButton = editing
            },
            onCommit: {
                self.showClearButton = false
            }
        )
        .onReceive(textObserver.$debouncedText) { (debounced) in
            onDebouncedChange(debounced)
        }
        .modifier(
            TextWithClearButton(
                text: $textObserver.searchText,
                isVisible: $showClearButton
            )
        )
        .padding(.horizontal)
        .padding(.vertical, 10)
        // TODO: Make same background style for other views
        .background(Color(.secondarySystemBackground))
        // I find this method of rounding corners very weird, but not sure of an alternative
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 16.0, height: 1.0)))
    }
}

class TextFieldObserver: ObservableObject {
    @Published var debouncedText = ""
    @Published var searchText = ""
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        $searchText
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] debounced in
                self?.debouncedText = debounced
            })
            .store(in: &subscriptions)
    }
}

struct TextWithClearButton: ViewModifier {
    @Binding var text: String
    @Binding var isVisible: Bool
    
    func body(content: Content) -> some View {
        HStack {
            content
            Spacer()
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(Color(.placeholderText))
                .opacity(!text.isEmpty ? 1 : 0)
                .onTapGesture { self.text = "" }
        }
    }
}
