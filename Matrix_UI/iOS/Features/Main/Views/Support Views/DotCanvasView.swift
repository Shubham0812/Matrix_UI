//
//  DotCanvasView.swift
//  Matrix_UI
//
//  Created by Shubham on 25/10/24.
//

import SwiftUI

struct DotCanvasView: View {
    let dots: [CanvasShape]
    let dotSize: CGFloat
    
    var color: Color = .white
    
    
    var body: some View {
        Canvas { context, size in
            for dot in dots {
                context.fill(
                    Path(ellipseIn: CGRect(
                        x: dot.x - dotSize / 4,
                        y: dot.y - dotSize / 4,
                        width: dotSize,
                        height: dotSize
                    )),
                    with: .color(color)
                )
            }
        }
    }
}

#Preview {
    DotCanvasView(dots: [], dotSize: 23)
}
