//
//  Phone.swift
//  Patterns
//
//  Created by Asif Habib on 09/09/25.
//

/**
 This pattern follows OCP and SRP
 In below implementation, Different phone states (normal, vibrate and silent ) are there. Each phone state has its own implementation. A new state can be added by adding a new State class without changing existing states.
 */

import SwiftUI

protocol PhoneState {
    func onReceiveCall()
}

struct Phone : View {
    @State var phoneState: PhoneState
    
    var body: some View {
        VStack {
            Text("Current State: \(phoneState.self)")
            VStack(spacing: 20) {
                ModeSelector(mode: $phoneState, newMode: NormalMode(), text: "Normal")
                ModeSelector(mode: $phoneState, newMode: SilentMode(), text: "Silent")
                ModeSelector(mode: $phoneState, newMode: VibrateMode(), text: "Vibrate")
            }
            Button(action: {
                phoneState.onReceiveCall()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 200, height: 50)
                    Text("Receive call")
                        .foregroundStyle(.white)
                }
                
                    
                    
            }
        }
        
    }
}

struct ModeSelector: View {
    @Binding var mode: PhoneState
    var newMode: PhoneState
    @State var text = ""
    var body: some View {
        VStack {
            Button(action: {
                self.mode = newMode
            }) {
                Text(text)
            }
        }
    }
}

class NormalMode: PhoneState {
    func onReceiveCall() {
        print("Phone in normal mode")
    }
}

class SilentMode: PhoneState {
    func onReceiveCall() {
        print("Phone in silent mode")
        
    }
}
class VibrateMode: PhoneState {
    func onReceiveCall() {
        print("Phone in vibrate mode")
    }
}

#Preview {
    Phone(phoneState: NormalMode())
}
