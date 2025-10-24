//
//  ContentView.swift
//  Aisle_Notes
//
//  Created by Asif Habib on 16/07/25.
//

import SwiftUI

struct ContentView: View {
    enum Step {
        case phone
        case otp(phone: String)
        case notes
    }
    
    @State private var step: Step = .phone
    
    var body: some View {
        switch step {
        case .phone:
            PhoneNumberView { phone in
                step = .otp(phone: phone)
            }
        case .otp(let phone):
            OTPView(phoneNumber: phone, onGoBack: {
                step = .phone
            }) { token in
                step = .notes
            }
        case .notes:
            DashboardView()
        }
    }
}

#Preview {
    ContentView()
}
