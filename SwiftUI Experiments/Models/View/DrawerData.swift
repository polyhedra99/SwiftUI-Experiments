//
//  DrawerData.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/14/24.
//

import SwiftUI

class DrawerData: ObservableObject {
    @Published var rootSelection: String = Strings.DRAWER_HOME
    @Published var isDrawerPresented: Bool = false
    // I feel like this naming ended up being weird
    @Published var shouldPresentSettings: Bool = false
}
