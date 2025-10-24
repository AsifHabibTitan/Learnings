//
//  GenderPicker.swift
//  Onboarding-2.0
//
//  Created by Asif Habib on 24/10/25.
//
import SwiftUI


struct GenderButton: View {
    var title: String
    var imageName: String
    var body: some View {
        Button(action: {}) {
            RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                .foregroundStyle(.clear)
                .border(.black)
                .overlay {
                    VStack(spacing: 4) {
                        Image(imageName)
                        Text(title)
                            .font(
                            Font.custom("DM Sans", size: 18)
                            .weight(.medium)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Constants.Colors.TextTextPrimary)
//                            .frame(width: 124, alignment: .top)
                            
                    }
                }
        }
    }
}

//#Preview {
//    GenderButton(title: "Male", imageName: "male")
//        
//}
struct GenderPicker: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                GenderButton(title: "Male", imageName: "male")
                GenderButton(title: "Female", imageName: "female")
            }
            .frame(maxHeight: 155)
            
            Button(action : {})  {
                VStack(alignment: .center, spacing: 4) { }
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
                .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50, alignment: .center)
                .cornerRadius(8)
                .overlay(
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                        .inset(by: 0.5)
                        
                        .stroke(Constants.Colors.ButtonButtonSecondary, lineWidth: 1)
                        .frame(height: 50)
                        
                        Text("Prefer not to say")
                            .font(
                                Constants.Fonts.Medium18
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Constants.Colors.TextTextPrimary)
                    }
                    
                )
//                Rectangle()
//                    .foregroundStyle(.clear)
//                    .overlay {
//                        Text("Prefer not to say")
//                            .padding(.horizontal, 16)
//                            .padding(.vertical, 24)
//                    }
//                    .border(.black)
//                    .cornerRadius(8)
//                    .frame(maxHeight: 50)
            }
        }
    }
}

#Preview {
    GenderPicker()
}
