//
//  MatrixViewModel.swift
//  Matrix_UI
//
//  Created by Shubham on 25/10/24.
//

import SwiftUI
import Combine

@Observable
class MatrixViewModel {
    
    // MARK: - Variables
    var dots: [CanvasShape]
    var touchLocation: CGPoint = .zero
    var dotSpacing: CGFloat = 10
    
    var touchBoundingSize: CGFloat = 25
    var dotInertia: CGFloat = 0.5
    
    private var cancellables: Set<AnyCancellable> = []
    private let updateSubject = PassthroughSubject<Void, Never>()
    
    
    // MARK: - Inits
    init() {
        dots = []
        setupUpdateTimer()
    }
    
    
    // MARK: - Functions
    private func setupUpdateTimer() {
        Timer.publish(every: 1/120, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateSubject.send()
            }
            .store(in: &cancellables)
        
        updateSubject
            .collect(.byTime(DispatchQueue.main, .milliseconds(16)))
            .sink { [weak self] _ in
                self?.updateDots()
            }
            .store(in: &cancellables)
    }
    
    func initializeDots(in size: CGSize) {
        let rows = Int(size.height / dotSpacing)
        let columns = Int(size.width / dotSpacing)
        
        dots = (0..<rows).flatMap { row in
            (0..<columns).map { column in
                let x = CGFloat(column) * dotSpacing
                let y = CGFloat(row) * dotSpacing
                return CanvasShape(x: x, y: y, originX: x, originY: y)
            }
        }
    }
    
    func updateDots() {
        let touchBoundingSizeSquared = touchBoundingSize * touchBoundingSize
        dots = dots.map { dot in
            
            var updatedDot = dot
            
            let dx = touchLocation.x - updatedDot.x
            let dy = touchLocation.y - updatedDot.y
            
            let distanceSquared = dx*dx + dy*dy
            
            if distanceSquared < touchBoundingSizeSquared {
                let distance = sqrt(distanceSquared)
                let force = (touchBoundingSize - distance) / touchBoundingSize
                let angle = atan2(dy, dx)
                let targetX = updatedDot.x - cos(angle) * force * 20
                let targetY = updatedDot.y - sin(angle) * force * 20
                
                updatedDot.vx += (targetX - updatedDot.x) * dotInertia
                updatedDot.vy += (targetY - updatedDot.y) * dotInertia
            }
            
            updatedDot.vx *= 0.9
            updatedDot.vy *= 0.9
            
            updatedDot.x += updatedDot.vx
            updatedDot.y += updatedDot.vy
            
            let dx2 = updatedDot.originX - updatedDot.x
            let dy2 = updatedDot.originY - updatedDot.y
            let distance2Squared = dx2*dx2 + dy2*dy2
            
            if distance2Squared > 1 {
                updatedDot.x += dx2 * 0.03
                updatedDot.y += dy2 * 0.03
            }
            
            return updatedDot
        }
    }
}
