import SwiftUI

struct ToggleItem: Identifiable {
    var id: Int
    var isOn: Bool = false
}

class ViewModel: ObservableObject {
    @Published var values: [ToggleItem]
    
    init(values: [ToggleItem] = []) {
        self.values = values
        createToggles()
    }

    func createToggles() {
        self.values = (0..<10).map { ToggleItem(id: $0, isOn: false) }
    }
}

public struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    // Computed binding for master toggle
    private var allOnBinding: Binding<Bool> {
        Binding<Bool>(
            get: {
                viewModel.values.allSatisfy { $0.isOn }
            },
            set: { newValue in
                viewModel.values = viewModel.values.map { ToggleItem(id: $0.id, isOn: newValue) }
            }
        )
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Toggle("Master", isOn: allOnBinding)
                .toggleStyle(SwitchToggleStyle())
                .tint(.blue)
                .padding()
            
            ForEach(viewModel.values) { item in
                ToggleSubItem(
                    label: "Toggle \(item.id)",
                    isOn: Binding(
                        get: {
                            item.isOn
                        },
                        set: { newValue in
                            if let index = viewModel.values.firstIndex(where: { $0.id == item.id }) {
                                viewModel.values[index].isOn = newValue
                            }
                        }
                    )
                )
            }
        }
        .padding()
    }
}

struct ToggleSubItem: View {
    var label: String
    var isOn: Binding<Bool>
    
    var body: some View {
        Toggle(label, isOn: isOn)
            .toggleStyle(SwitchToggleStyle())
            .tint(.orange)
    }
}

#Preview {
    ContentView()
}
