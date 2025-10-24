//
//  HeightSelector.swift
//  Onboarding-2.0
//
//  Created by Asif Habib on 22/10/25.
//

import SwiftUI

enum Unit: String, CaseIterable, Identifiable {
    var id: String {  rawValue }
    case inches = "feet/inches"
    case cm = "cms"
    
    var short: String {
        switch self {
        case .cm:
            return "cm"
        case .inches:
            return "ft"
        }
    }
}
struct HeightSelector: View {
    @State private var selectedUnit: Unit = .inches
    @State private var selectedHeightValueInCM: Int = 105
    private var selectedHeightValueInInches: Int {
        get {
            convertCentimetersToFeetInches(Double(selectedHeightValueInCM)).feet
        }
        set {
            
        }
    }
    
    private var selectionRange: ClosedRange<Int> { selectedUnit == .inches ? 2...8 : 100 ... 190 }
    
    private func convertCentimetersToFeetInches(_ centimeters: Double) -> (feet: Int, inches: Int) {
        // 1 inch = 2.54 cm
        let totalInches = centimeters / 2.54
        let feet = Int(totalInches / 12)
        let inches = Int(round(totalInches.truncatingRemainder(dividingBy: 12)))
        
        return (feet, inches)
    }
    
    private func feetInchesToCentimeters(feet: Int, inches: Int) -> Double {
            Double(feet * 12 + inches) * 2.54
        }
    
    var body: some View {
        Picker("Unit", selection: $selectedUnit) {
            ForEach(Unit.allCases) { option in
                Text(option.rawValue).tag(option)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: selectedUnit, { oldValue, newValue in
            selectedUnit = newValue
        })
        .padding(.bottom, 32)
        HStack(spacing: -20) {
            Picker("HeightValue", selection: $selectedHeightValueInCM) {
                ForEach(selectionRange, id: \.self) { option in
                    HStack(spacing: 12) {
                        Text("\(option)")
                        Text("\(selectedUnit.short)")
                    }
                        .font(
                            Constants.Fonts.Medium18
                        )
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(Constants.Colors.TextTextPrimary)
    //                    .frame(width: 12, alignment: .trailing)
                }
            }
            .pickerStyle(.wheel)
            
            if selectedUnit == .inches {
                let (feet, inches) = convertCentimetersToFeetInches(Double(selectedHeightValueInCM))
                Picker("HeightValue", selection: Binding(
                    get: { inches },
                    set: { newFeet in
                        selectedHeightValueInCM = Int(feetInchesToCentimeters(
                            feet: newFeet,
                            inches: inches
                        ))
                    }
                )) {
                    ForEach(selectionRange, id: \.self) { option in
                        HStack(spacing: 12) {
                            Text("\(option)")
                            Text("\(selectedUnit.short)")
                        }
                            .font(
                                Constants.Fonts.Medium18
                            )
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Constants.Colors.TextTextPrimary)
        //                    .frame(width: 12, alignment: .trailing)
                    }
                }
                .pickerStyle(.wheel)
            }
        }
       
       

    }
}

#Preview {
    HeightSelector()
}
