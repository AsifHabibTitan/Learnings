//
//  Picker.swift
//  UIs
//
//  Created by Asif Habib on 23/09/25.
//
import SwiftUI

struct PickerView: View {
    var body: some View {
        Picker("Test", selection: 1...4) {
            Text("\(4)")
        }
    }
}

#Preview {
    PickerView()
}
