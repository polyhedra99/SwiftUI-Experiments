//
//  CircularProgressView.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/12/24.
//

import SwiftUI

struct CircularProgressView: View {
    @Binding var isLoading: Bool
    
    var body: some View {
        if (isLoading) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .padding()
        }
    }
}
