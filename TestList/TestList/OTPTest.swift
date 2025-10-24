//
//  OTPTest.swift
//  TestList
//
//  Created by Asif Habib on 06/09/25.
//
import SwiftUI

struct OTPTest: View {
    @State var otpTextArray: [String] = Array(repeating: "", count: 4)
    @FocusState var focusedIndex: Int?
    @State var animatedIndex: Int? = 0
    var body: some View {
        HStack {
            ForEach(0..<4, id: \.self) { index in
                TextField("", text: Binding(
                    get: { self.otpTextArray[index] },
                    set: { newValue in
                        self.otpTextArray[index] = newValue
                        if !otpTextArray[index].isEmpty && index < otpTextArray.count - 1 {
                            focusedIndex = index + 1
                        }
                        withAnimation {
                            animatedIndex = index
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                            if animatedIndex == index {
                                animatedIndex = nil
//                            }
                        }
                    }
                )
                )
                .scaleEffect(animatedIndex == index ? 2: 1)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                    .frame(width: 40, height: 40)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    .focused($focusedIndex, equals: index)
                    
                    
            }
        }
        
    }
}

#Preview {
    OTPTest()
}
