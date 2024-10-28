//
//  MatrixView.swift
//  Matrix_UI
//
//  Created by Shubham on 25/10/24.
//

import SwiftUI

struct MatrixEffect: View {
    
    // MARK: - Variables
    @State var matrixViewModel: MatrixViewModel  = .init()
    
    var dotSize: CGFloat = 1.25
    var color: Color = .white

    // MARK: - Views
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                DotCanvasView(dots: matrixViewModel.dots, dotSize: dotSize, color: color)
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                matrixViewModel.touchLocation = value.location
                            }
                            .onEnded { _ in
                                matrixViewModel.touchLocation = CGPoint(x: -1000, y: -1000)
                            }
                    )
                    .onAppear {
                        matrixViewModel.initializeDots(in: geometry.size)
                    }
                    .onChange(of: geometry.size) { oldSize, newSize in
                        matrixViewModel.initializeDots(in: newSize)
                    }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}


#Preview {
    ZStack {
        LinearGradient(
            gradient: Gradient(colors: [.black, .black, .black, .gray, .gray]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
        MatrixEffect()
    }
}
