//
//  ContentView.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/14/24.
//

import SwiftUI
import SimpleToast

struct ContentView: View {
    @StateObject private var toastData = ToastData()
    @StateObject private var drawerData = DrawerData()
    
    @Namespace var animation
    
    // Everything nesessary to display toasts and side drawer
    var body: some View {
        ZStack {
            ToastContainer {
                TabView(selection: $drawerData.rootSelection) {
                    TabItem(tag: Strings.DRAWER_HOME) { ReposView() }
                    TabItem(tag: Strings.DRAWER_HISTORY) { HistoryView() }
                }
                .sheet(isPresented: $drawerData.shouldPresentSettings) {
                    SettingsView()
                }
            }

            DrawerContainerView(animation: animation)
        }.environmentObject(drawerData)
    }
    
    // MARK: - Internals
    // This one looks a bit confusing, it's abstracted out for a reason
    // Fairly speaking, this implementation can't handle multiple toasts in a short period of time, but I don't think it really matters here
    @ViewBuilder
    private func ToastContainer(
        @ViewBuilder _ content: @escaping () -> some View
    ) -> some View {
        let toastOptions = SimpleToastOptions(
            alignment: .bottom,
            hideAfter: ViewConstants.TOAST_DURATION
        )
        ZStack {
            content()
        }
        .environmentObject(toastData)
        .simpleToast(
            isPresented: $toastData.isToastPresented,
            options: toastOptions
        ) {
            ToastLabel(toastData.toastMessage)
        }
        .onChange(of: toastData.toastMessage) { _, new in
            if (!new.isEmpty) {
                toastData.isToastPresented = true
            }
        }
        .onChange(of: toastData.isToastPresented) { old, new in
            if (old && !new) {
                toastData.toastMessage = ""
            }
        }
    }
    
    @ViewBuilder
    private func TabItem(
        tag: String,
        @ViewBuilder _ content: @escaping () -> some View
    ) -> some View {
        NavigationView {
            content()
        }
        .toolbar(.hidden, for: .tabBar)
        .tag(tag)
    }
    
    @ViewBuilder
    private func ToastLabel(_ message: String) -> some View {
        Label(
            toastData.toastMessage,
            systemImage: "exclamationmark.triangle"
        )
        .padding()
        .background(.thickMaterial)
        .clipShape(Capsule())
        .padding()
    }
}
