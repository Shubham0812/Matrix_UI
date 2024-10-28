//
//  DesignRowView.swift
//  Matrix_UI
//
//  Created by Shubham on 25/10/24.
//

import SwiftUI

struct DesignRowView: View {
    
    // MARK: - Variables
    @Binding var colorPresets: [Color]
    @Binding var selectedColorPreset: Int
    
    @State var viewAppeared = false
    
    // MARK: - Views
    var body: some View {
        ScrollViewReader { scrollView in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 24) {
                    ForEach(Array(zip(colorPresets.indices, colorPresets)), id: \.1) { (ix,colorPreset) in
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(colorPreset.opacity(0.85))
                            .overlay {
                                let isSelected = ix == self.selectedColorPreset
                                CheckmarkView()
                                    .scaleEffect(isSelected ?  0.7 : 0)
                                    .opacity(isSelected ? 1 : 0)
                                    .animation(.smooth, value: self.selectedColorPreset)
                            }
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lineWidth: 1.5)
                            }
                            .frame(width: 44, height: 44)
                            .scaleEffect(self.viewAppeared ? 1 : 0.3)
                            .opacity(self.viewAppeared ? 1 : 0)
                            .id(ix)
                            .animation(.smooth(duration: 0.25).delay(0.1 * Double(ix + 1)), value: self.viewAppeared)
                            .onTapGesture {
                                withAnimation(.smooth(duration: 0.65)) {
                                    self.selectedColorPreset = ix
                                    scrollView.scrollTo(ix, anchor: .center)
                                }
                            }
                    }
                    
                    Spacer()
                }
                .padding(2)
            }
        }
        
        .onAppear() {
            self.viewAppeared = true
        }
    }
    
    // MARK: - Functions
    
}
#Preview {
    DesignRowView(colorPresets: .constant([.teal, .red, .blue]), selectedColorPreset: .constant(1))
        .safeAreaPadding(.trailing, 12)
        .safeAreaPadding(.leading, 24)
        .padding(.horizontal, -24)
        .padding(.leading, 24)
}
