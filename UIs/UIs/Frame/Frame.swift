//
//  Frame.swift
//  UIs
//
//  Created by Asif Habib on 12/09/25.
//

import SwiftUI

struct Frame: View {
    @State var frame: CGRect?
    var body: some View {
        VStack{
            Rectangle()
                .frame(width: 400, height: 400)
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear {
                                frame = proxy.frame(in: .global)
                                print("Frame in global: \(frame)")
                                frame = proxy.frame(in: .local)
                                print("Frame in global: \(frame)")
                                
                                
                                
                            }
                    }
                )
        }
    }
}

#Preview {
    Frame()
}
