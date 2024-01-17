//
//  ErrorTextView.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/13/24.
//

import SwiftUI

struct ErrorTextView: View {
    var error: String
    
    var body: some View {
        HStack {
            Text(error)
                .foregroundStyle(.red)
                .padding(.horizontal, 16)
            Spacer()
        }
    }
}
