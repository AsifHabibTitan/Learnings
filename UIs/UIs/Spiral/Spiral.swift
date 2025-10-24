//
//  Spiral.swift
//  UIs
//
//  Created by Asif Habib on 11/09/25.
//

import SwiftUI

struct Spiral : View {
    @State var isAnimating: Bool = false
    @State var animationXoffset: CGFloat = 0
    @State var animationYoffset: CGFloat = 0
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 30, height: 30)
                .offset(x: animationXoffset, y: animationYoffset)
                .onTapGesture {
                    startAnimation()
                }
        }
        .frame(width: 400, height: 400)
        .background(Color.gray)
        
    }
    func startAnimation() {

        var targetX:Double = 170 // UIScreen.main.bounds.width / 2 - 20
        var targetY:Double = 170 // UIScreen.main.bounds.height / 2 - 20
        let duration: Double = 0.4
        var i = 0
        while targetX > 0 && targetY > 0 {
            withAnimation(.linear(duration: duration).delay(Double(i) * duration)) {
                
                switch i % 4 {
                case 0:
                    animationXoffset = targetX
                    targetX -= 20
                case 1:
                    animationYoffset = targetY
                    targetY -= 20
                case 2:
                    animationXoffset = -targetX
                    targetX -= 20
                case 3:
                    animationYoffset = -targetY
                    targetY -= 20
                default:
                    print("None")
                    
                }
            }
            i += 1
        }
//        withAnimation(.linear(duration: 2)) {
//            animationXoffset = targetX
//        }
//        withAnimation(.linear(duration: 2).delay(2)) {
//            animationYoffset = targetY
//        }
//        withAnimation(.linear(duration: 2).delay(4)) {
//            animationXoffset = -targetX
//        }
//        withAnimation(.linear(duration: 2).delay(6)) {
//            animationYoffset = -targetY
//            
//        }
    }
//    func moveToTarget(from: inout CGFloat, to: CGFloat, delay: Double) {
//        withAnimation(.linear(duration: 2).delay(delay)) {
//            from = to
//        }
//    }
}

#Preview {
    Spiral()
}
