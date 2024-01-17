//
//  LeftDrawerToolbarItem.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/12/24.
//

import SwiftUI

struct LeftDrawerToolbarItem: ToolbarContent {
    @Binding var isDrawerPresented: Bool
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button {
                withAnimation(.easeInOut) {
                    isDrawerPresented.toggle()
                }
            } label: {
                Image(systemName: "line.3.horizontal")
            }
            .buttonStyle(.plain)
            .opacity(ViewConstants.TOOLBAR_ITEM_OPACTIY)
        }
    }
}
