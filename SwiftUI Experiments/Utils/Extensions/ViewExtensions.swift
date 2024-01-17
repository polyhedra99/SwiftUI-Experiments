//
//  ViewExtensions.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/13/24.
//

import SwiftUI

extension View {
    func hideIfNot(_ condition: Bool) -> some View {
        self.opacity(condition ? 1 : 0)
    }
    
    func desideOnColorScheme(themeSelection: ThemeSelection) -> some View {
        return switch themeSelection {
        case .dark: self.preferredColorScheme(.dark)
        case .light: self.preferredColorScheme(.light)
        default: self.preferredColorScheme(.none)
        }
    }
}
