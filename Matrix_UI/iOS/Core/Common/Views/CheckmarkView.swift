//
//  CheckmarkView.swift
//  Matrix_UI
//
//  Created by Shubham on 25/10/24.
//

import SwiftUI

struct CheckmarkView: View {
    
    // MARK: - Variables
        
    // MARK: - Views
    var body: some View {
        Image(systemName: "checkmark")
            .foregroundColor(.white)
            .font(.system(size: 28, weight: .bold))
            .frame(width: 44, height: 44)
    }
}
#Preview {
    CheckmarkView()
}
