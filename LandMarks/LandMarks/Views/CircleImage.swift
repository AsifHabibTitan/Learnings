//
//  CircleImage.swift
//  LandMarks
//
//  Created by Asif Habib on 28/11/24.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    var body: some View {
        image
            .resizable(resizingMode: .stretch)
            .clipShape(Circle())
            .overlay(Circle().stroke(.white, lineWidth: 5))
            .shadow(radius: 10)
    }
}

#Preview {
    CircleImage(image: Image("Forestrek"))
}
