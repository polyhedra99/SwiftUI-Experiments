//
//  DrawerContainerView.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/14/24.
//

import SwiftUI

// TODO: Not presented correctly after openign the drawer in landscape
struct DrawerContainerView: View {
    @EnvironmentObject var drawerData: DrawerData
    
    var animation: Namespace.ID
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.thinMaterial)
                .hideIfNot(drawerData.isDrawerPresented)
                .animation(.easeIn, value: drawerData.isDrawerPresented)
                .opacity(ViewConstants.DRAWER_MATERIAL_OPACITY)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        drawerData.isDrawerPresented = false
                    }
                }
            HStack {
                let drawerWidth = UIScreen.main.bounds.width * ViewConstants.DRAWER_FRACTION
                DrawerContentView(animation: animation)
                    .frame(width: drawerWidth)
                    .offset(x: self.drawerData.isDrawerPresented ? 0 : -drawerWidth * 2)
                Spacer()
            }
        }
        .ignoresSafeArea(.container, edges: [.bottom])
    }
}
