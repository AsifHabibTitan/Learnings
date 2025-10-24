//
//  Constants.swift
//  Onboarding-2.0
//
//  Created by Asif Habib on 22/10/25.
//
import SwiftUICore

enum Constants {
    enum Colors {
        static let TextTextPrimary = Color(red: 0, green: 0, blue: 0)
        static let ButtonButtonSecondary: Color = Color(red: 0.7, green: 0.7, blue: 0.7)
        
    }
    enum Fonts {
        static let Medium18 = Font.custom("DM Sans", size: 18).weight(.medium)
        static let SemiBold18 = Font.custom("DM Sans", size: 18)
            .weight(.semibold)
        static let MAMedium81 = Font.custom("Montserrat Alternates", size: 81)
            .weight(.medium)
        static let MAMedium20 = Font.custom("Montserrat Alternates", size: 20)
            .weight(.medium)
        static func fontWithSize(_ size: CGFloat, weight: Font.Weight) -> Font {
            Font.custom("DM Sans", size: size).weight(weight)
        }
    }
    
}
