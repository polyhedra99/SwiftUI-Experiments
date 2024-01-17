//
//  ThemeSelection.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/15/24.
//

enum ThemeSelection: String, Identifiable {
    case dark, light, system
    
    static var defaultTheme: Self = .dark
    
    var id: Self { self }
}
