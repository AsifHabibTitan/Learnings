//
//  ExpandingToCorners.swift
//  UIs
//
//  Created by Asif Habib on 10/09/25.
//
import SwiftUI

struct ExpandingToCorners: View {
    @State var isAnimating: Bool = false
    var body: some View {
        ZStack {
            MovingBox(isAnimating: $isAnimating, finalPositionDirections: [-1, -1], callback: startAnimation)
            MovingBox(isAnimating: $isAnimating, finalPositionDirections: [-1, 1], callback: startAnimation)
            MovingBox(isAnimating: $isAnimating, finalPositionDirections: [1, -1], callback: startAnimation)
            MovingBox(isAnimating: $isAnimating, finalPositionDirections: [1, 1], callback: startAnimation)
        }
        
    }
    func startAnimation() {
        withAnimation(.linear(duration: 1).repeatForever()) {
            isAnimating = true
        }
    }
}
struct MovingBox: View {
    @Binding var isAnimating: Bool
    var finalPositionDirections: [Int]
    var callback: () -> ()
    var xPositionAfterAnimation: CGFloat { CGFloat(finalPositionDirections[0]) * (UIScreen.main.bounds.width / 2 - 50)
    }
    var yPositionAfterAnimation: CGFloat { CGFloat(finalPositionDirections[1]) * (UIScreen.main.bounds.height / 2 - 50)
    }
    var body: some View {
        Rectangle()
            .frame(width: 100, height: 100)
            .onTapGesture {callback()}
            .offset(x: isAnimating ? xPositionAfterAnimation  : 0, y: isAnimating ? yPositionAfterAnimation : 0 )
    }
}

extension CGFloat {
    var screenHeight: CGFloat { UIScreen.main.bounds.height }
    var screenWidth: CGFloat { UIScreen.main.bounds.width }
}

#Preview {
    ExpandingToCorners()
}
