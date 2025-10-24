//
//  DOBSelector.swift
//  Onboarding-2.0
//
//  Created by Asif Habib on 24/10/25.
//
import SwiftUI

struct DOBSelector: View {
    @Binding var selectedDate: Date
    var body: some View {
        VStack {
            HStack {
                Text("Date of birth")
                    .font(Constants.Fonts.SemiBold18)
                    .foregroundColor(.black)
                Spacer()
                Button(action: {
                    debugPrint("Close")
                }) {
                    Image("cross")
                        .frame(width: 15, height: 15)
                }
            }
            DatePicker("", selection: $selectedDate, displayedComponents: [.date]).datePickerStyle(.wheel)
        }
        
    }
}

#Preview {
    DOBSelector(selectedDate: Binding( get : { Date() }, set: {_ in
        
    } ))
}
