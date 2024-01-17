//
//  SwiftUI_ExperimentsApp.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/2/24.
//

import SwiftUI

@main
struct SwiftUI_ExperimentsApp: App {
    @AppStorage(Strings.APP_STORAGE_THEME) var theme = ThemeSelection.defaultTheme
    
    var body: some Scene {
        WindowGroup {
            ContentView().desideOnColorScheme(themeSelection: theme)
        }
    }
}
