//
//  WeightSelector.swift
//  Onboarding-2.0
//
//  Created by Asif Habib on 22/10/25.
//
import SwiftUI
enum WeightUnit: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    
    case kg
    case lbs
}
struct WeightSelector: View {
    @State var selectedUnit: WeightUnit = .kg
    @State private var selectedWeight = 120
    @State private var scrollOffset: CGFloat = 0
    @State private var isScrolling = false

    private let impactFeedback = UIImpactFeedbackGenerator(style: .light)
    private var weightRange: ClosedRange<Int> {
        switch selectedUnit {
        case .kg:
            return 30...250
        case .lbs:
            return 66...550
        }
    }
    
    private var startValue: Int {
        weightRange.lowerBound
    }
    
    private var endValue: Int {
        weightRange.upperBound
    }
    var body: some View {
        Picker("Weight Unit", selection: $selectedUnit) {
            ForEach(WeightUnit.allCases) { option in
                Text(option.rawValue).tag(option)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: selectedUnit, { oldValue, newValue in
            selectedUnit = newValue
        })
        .padding(.bottom, 32)
        
        VStack {
            Text("\(self.selectedWeight)")
                .font(Constants.Fonts.MAMedium81)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
            
            GeometryReader { geometry in
                ZStack (alignment: .center) {
                    ScrollViewReader { proxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .bottom, spacing: 0) {
                                // Leading spacer to center first item
                                Color.clear
                                    .frame(width: geometry.size.width / 2)
                                
                                ForEach(weightRange, id: \.self) { i in
                                    VStack(alignment: .center) {
                                        let isMultipleOf10 = i % 10 == 0
                                        if isMultipleOf10 {
                                            Text("\(i)")
                                                .font(Constants.Fonts.MAMedium20)
                                                .fixedSize()
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.black.opacity(0.31))
                                        }
                                        
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .frame(width: 1, height: isMultipleOf10 ? 25 : 17)
                                            .background(.black.opacity(isMultipleOf10 ? 1 : 0.29))
                                            .padding(.trailing, 6.5)
                                            .padding(.leading, 6.5)
                                            .contentMargins(.zero)
                                    }
                                    .frame(width: 13)
                                    .id(i)
                                    .gesture(TapGesture().onEnded({
                                        self.selectedWeight = i
                                        withAnimation {
                                            proxy.scrollTo(i, anchor: .center)
                                        }
                                    }))
                                }
                                
                                // Trailing spacer to center last item
                                Color.clear
                                    .frame(width: geometry.size.width / 2)
                            }
                            .padding(.bottom, geometry.size.height / 2 - 10)
                            .background(
                                GeometryReader { geo in
                                    Color.clear
                                        .onChange(of: geo.frame(in: .named("scroll")).minX) { oldValue, newValue in
                                            scrollOffset = newValue
                                            updateSelectedIndex(geometry: geometry)
                                            
                                            isScrolling = true
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                if abs(newValue - scrollOffset) < 0.1 {
                                                    isScrolling = false
                                                    // Snap to nearest position
                                                    withAnimation(.easeOut(duration: 0.2)) {
                                                        proxy.scrollTo(self.selectedWeight, anchor: .center)
                                                    }
                                                }
                                            }
                                        }
                                }
                            )
                        }
                        .coordinateSpace(name: "scroll")
                        .onAppear() {
                            impactFeedback.prepare()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                proxy.scrollTo(selectedWeight, anchor: .center)
//                                self.index = 120
                            }
                        }
                    }
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 2, height: 48)
                        .background(Color.black)
                        .allowsHitTesting(false)
                }
//                .border(.red)
            }
            .frame(height: 100)
            
        }
        .onChange(of: selectedWeight) { oldValue, newValue in
            impactFeedback.impactOccurred()
        }
    }
    
    private func updateSelectedIndex(geometry: GeometryProxy) {
        let itemWidth: CGFloat = 13
        
        // scrollOffset is the minX of the content in the scroll coordinate space
        // When content scrolls left (user scrolls right), minX becomes more negative
        // At the center of screen, we want to know which item index that is
        
        let screenCenter = geometry.size.width / 2
        let contentPositionAtCenter = screenCenter - scrollOffset
        debugPrint("position", contentPositionAtCenter, "screenCenter", screenCenter, "scrollOffset", scrollOffset)
        // Subtract the leading spacer to get position in the items area
        let leadingSpacerWidth = geometry.size.width / 2
        let positionInItems = contentPositionAtCenter - leadingSpacerWidth
        
        // Divide by item width to get the item index (0-based in the range)
        let itemIndex = Int(floor(positionInItems / itemWidth))
        
        // Add 50 to get the actual value
        let calculatedIndex = itemIndex + startValue
        
        let clampedIndex = max(startValue, min(endValue, calculatedIndex))
        
        if clampedIndex != self.selectedWeight {
            self.selectedWeight = clampedIndex
        }
    }
}
#Preview {
    WeightSelector()
}
