//
//  ContentView.swift
//  Onboarding-2.0
//
//  Created by Asif Habib on 22/10/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {}){
                Image("CaretLeft")
            }
            Text("Set up your health and fitness details")
                .font(
                Font.custom("DM Sans", size: 24)
                .weight(.bold)
                )
                .foregroundColor(Constants.Colors.TextTextPrimary)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.top, 8)
                .padding(.bottom, 4)
            
            Text("Enter your fitness stats and health info to unlock data-driven plans and smarter tracking.")
            .font(Font.custom("DM Sans", size: 14))
            .foregroundColor(.black)

            .frame(maxWidth: .infinity, alignment: .topLeading)
            .opacity(0.6)
            .padding(.bottom, 40)
            
            InputFields()
            
        }
        .padding(16)
        
    }
}

struct InputFields: View{
    var body: some View {
        VStack {
            InputField(imageName: "cake", title: "Date of birth")
            Divider()
            InputField(imageName: "gender", title: "Gender")
            Divider()
            InputField(imageName: "height", title: "Height")
            Divider()
            InputField(imageName: "weight", title: "Weight")
            
        }
        
    }
}

struct InputField: View {
    @State var imageName: String
    @State var title: String
    var body: some View {
        HStack {
            HStack(spacing: 16) {
                Image(imageName)
                Text(title)
            }
            Spacer()
            Button(action: {debugPrint("clicked")}){
                Text("Select")
            }
        }
        .padding(.vertical, 16)
    }
}






#Preview {

//    GenderPicker()
//    HeightSelector()
//    WeightSelector()
//    ContentView()
}
