//
//  test.swift
//  Bookxpert
//
//  Created by Asif Habib on 21/05/25.
//

import Foundation
import SwiftUI

struct Temp: View {
    @Binding var selectedWeight: Int
    var body: some View {
        Picker("Weight", selection: $selectedWeight) {
            ForEach(20...50, id: \.self) { weight in
                Text("\(weight) Kg")
            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(width: 160)
        .tint(.clear)
        
//        .accentColor(.clear)
    }
}

#Preview() {
    Temp(selectedWeight: .constant(43))
}
