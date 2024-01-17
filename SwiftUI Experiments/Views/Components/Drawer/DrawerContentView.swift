//
//  DrawerContentView.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/14/24.
//

import SwiftUI

struct DrawerContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var drawerData: DrawerData
    
    var animation: Namespace.ID
    
    var body: some View {
        ZStack {
            DrawerBackground()
            
            VStack(alignment: .leading, spacing: 0) {
                DrawerHeaderImage()
                
                DrawerPrimaryItem(name: Strings.DRAWER_HOME, animation: animation)
                DrawerPrimaryItem(name: Strings.DRAWER_HISTORY, animation: animation)
                
                DrawerDivider()
                
                DrawerSettingsItem()
                
                Spacer()
            }
        }
    }
    
    // MARK: - Internals
    @ViewBuilder
    private func DrawerBackground() -> some View {
        // Came up with a quick hach as to not bother with themeing
        Rectangle().fill(.background)
        Color.gray.opacity(ViewConstants.DRAWER_GRAY_OPACITY)
    }
    
    @ViewBuilder
    private func DrawerHeaderImage() -> some View {
        let imageName = desideOnImageName()
        // Might not be scaled perfectly, but in production you get properly sized assets anyway
        Image(imageName)
            .resizable()
            .scaledToFit()
            .padding(.bottom, 24)
    }
    
    @ViewBuilder
    private func DrawerPrimaryItem(name: String, animation: Namespace.ID) -> some View {
        DrawerText(name: name)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.easeInOut) {
                    drawerData.rootSelection = name
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + ViewConstants.DEFAULT_ANIMATION_DELAY) {
                    withAnimation(.easeInOut) {
                        drawerData.isDrawerPresented = false
                    }
                }
            }
            .background(
                ZStack {
                    if drawerData.rootSelection == name {
                        Color.gray
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    } else {
                        Color.clear
                    }
                }
            )
    }
    
    @ViewBuilder
    private func DrawerSettingsItem() -> some View {
        Button {
            withAnimation(.easeInOut) {
                drawerData.isDrawerPresented = false
                drawerData.shouldPresentSettings = true
            }
        } label: {
            DrawerText(name: Strings.DRAWER_SETTINGS)
                .contentShape(Rectangle())
        }.buttonStyle(.plain)
    }
    
    @ViewBuilder
    private func DrawerText(name: String) -> some View {
        HStack {
            Text(name)
                .font(.headline)
                .fontWeight(.bold)
                .padding()
                .padding(.horizontal, 8)
            Spacer()
        }
    }
    
    @ViewBuilder
    private func DrawerDivider() -> some View {
        Divider().overlay(.foreground).padding()
    }
    
    private func desideOnImageName() -> String {
        if colorScheme == .dark {
            return "StarrySky"
        } else {
            return "BlueSky"
        }
    }
}
