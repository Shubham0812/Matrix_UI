//
//  MainView.swift
//  Matrix_UI
//
//  Created by Shubham on 25/10/24.
/// CONTENT BY ``@SHUBHAM_IOSDEV``

import SwiftUI

struct MainView: View {
    
    // MARK: - Variables
    @State var editMode = false
    @State var colorPresets: [Color] = [.white, .init(hex: "39FF14"), .init(hex: "00FFFF"), .init(hex: "FF5E00") , .init(hex: "DAA520"), .init(hex: "FF00FF")]
    
    @State var selectedColorIndex = 0
    
    
    // MARK: - Views
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.5)
                .ignoresSafeArea()
            
            MatrixEffect(dotSize: 1.25, color: colorPresets[selectedColorIndex])
                .ignoresSafeArea()
        }
        .overlay(alignment: .topTrailing) {
            Button {
                withAnimation(.smooth) {
                    editMode.toggle()
                }
            } label: {
                Image(systemName: editMode ? "checkmark" : "highlighter")
                    .font(.system(size: 24, weight: .semibold))
            }
            .tint(.white)
            .padding(.trailing, 24)
        }
        .overlay(alignment: .bottom) {
            HStack {
                DesignRowView(colorPresets: $colorPresets, selectedColorPreset: $selectedColorIndex)
                    .opacity(editMode ? 1 : 0)
                    .animation(.smooth, value: editMode)
                    .safeAreaPadding(.trailing, 12)
                    .safeAreaPadding(.leading, 24)
                    .padding(.horizontal, -24)
                    .offset(y: editMode ? 0 : 72)
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    MainView()
        .preferredColorScheme(.dark)
}
