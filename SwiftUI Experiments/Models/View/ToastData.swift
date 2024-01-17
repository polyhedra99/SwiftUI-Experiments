//
//  ToastData.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/13/24.
//

import SwiftUI

class ToastData: ObservableObject {
    @Published var toastMessage: String = ""
    @Published var isToastPresented: Bool = false
}
