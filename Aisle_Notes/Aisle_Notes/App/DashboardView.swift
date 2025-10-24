//
//  DashboardView.swift
//  Aisle_Notes
//
//  Created by Asif Habib on 16/07/25.
//

import SwiftUI

struct DashboardView: View {
    @State var selectedTab: TabSelection = .notes
    @StateObject var dashboardVM = DashboardViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HeaderSection()
            NotesScreenView(viewModel: dashboardVM)
            CustomTabBar(selected: $selectedTab)
        }
        .onAppear() {
            dashboardVM.fetchNotes()
        }
    }
}

// MARK: - Main Notes Screen
struct NotesScreenView: View {
    @ObservedObject var viewModel: DashboardViewModel
    var body: some View {
        let profiles = viewModel.inviteProfiles
        let firstName = profiles.isEmpty ? "meena" : profiles[0].generalInformation.firstName
        let photo = profiles.isEmpty ? "" : profiles[0].photos[0].photo
        let age = profiles.isEmpty ? 0 : profiles[0].generalInformation.age
        return ScrollView(showsIndicators: false){
            VStack(alignment: .leading, spacing: 20) {
                
                FeaturedNoteCard(imageName: photo, name: firstName.capitalized, age: age, noteCount: profiles.count)
                UpgradeSection()

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(viewModel.likeProfiles, id: \.self) { profile in
                            BlurredUserCard(imageName: profile.avatar, name: profile.firstName)
                        }
                    }
                    .padding(.horizontal)
                }
 
            }
            .padding(.top)
        }
        
    }
}

// MARK: - Header Section
struct HeaderSection: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("Notes")
                .font(.gilroy_800_27)
                .bold()
            Text("Personal messages to you")
                .font(.gilroy_600_18)
                .foregroundColor(.black)
        }
        .padding(.top, 33)
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Featured Note Card
struct FeaturedNoteCard: View {
    let imageName: String
    let name: String
    let age: Int
    let noteCount: Int

    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        return Button(action: {}) {
            ZStack(alignment: .bottomLeading) {
                if let url = URL(string: imageName) {
                    AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView() // Loading
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                            case .failure:
                                Image(systemName: "meena") // Placeholder on failure
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .aspectRatio(contentMode: .fill)
                        .frame(width: screenWidth - 32, height: screenWidth - 32)
                        .cornerRadius(16)
                        .clipped()
                }
                

                VStack(alignment: .leading, spacing: 2) {
                    Text("\(name), \(age)")
                        .font(.gilroy_800_22)
                        .foregroundColor(.white)
                    Text("Tap to review \(noteCount)+ notes")
                        .font(.gilroy_600_15)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.black.opacity(0.3))
                .cornerRadius(16)
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - Upgrade Section
struct UpgradeSection: View {
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        return HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Interested In You")
                    .font(.gilroy_800_22)
                Text("Premium members can view all their likes at once")
                    .font(.gilroy_600_15)
                    .foregroundColor(.gray)
                
            }
            .frame(width: screenWidth * 0.55)
            .padding(.leading, 15)
            Spacer()
            Button(action: {}) {
                Text("Upgrade")
                    .font(.gilroy_800_15)
                    .foregroundColor(.black)
                    .padding(.horizontal, 26)
                    .padding(.vertical, 14)
                    .background(Color.yellow)
                    .cornerRadius(24)
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - Blurred User Card
struct BlurredUserCard: View {
    let imageName: String
    let name: String

    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let imageWidth = (screenWidth / 2) - 20
        return ZStack(alignment: .bottomLeading) {
            if let url = URL(string: imageName) {
                AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView() // Loading
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                        case .failure:
                            Image(systemName: "meena") // Placeholder on failure
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imageWidth, height: imageWidth * 1.4)
                    .blur(radius: 6)
                    .cornerRadius(16)
                    .clipped()
            }
           

            Text(name)
                .foregroundColor(.white)
                .bold()
                .padding()
        }
    }
}

// MARK: - Tab Bar
enum TabSelection: String { case discover, notes, matches, profile }

struct CustomTabBar: View {
    @Binding var selected: TabSelection
    
    var body: some View {
        HStack(spacing: 30) {
            tabItem(icon: "square.grid.2x2", label: "Discover", isSelected: selected == .discover)
            tabItem(icon: "envelope.fill", label: "Notes", isSelected: selected == .notes, badge: "9")
            tabItem(icon: "bubble.left.and.bubble.right.fill", label: "Matches", isSelected: selected == .matches, badge: "50+")
            tabItem(icon: "person.crop.circle", label: "Profile", isSelected: selected == .profile)
        }
        .frame(width: UIScreen.main.bounds.width)
    }

    private func tabItem(icon: String, label: String, isSelected: Bool, badge: String? = nil) -> some View {
        VStack(spacing: 4) {
            ZStack {
                Button(action: {
                    print("Tab Selected: \(label)")
                    if let newTab = TabSelection(rawValue: label.lowercased()) {
                        selected = newTab
                    }
                    
                }) {
                    Image(systemName: icon)
                        .font(.system(size: 20))
                        .foregroundColor(isSelected ? .black : .gray)
                }
                
                if let badge = badge {
                    Text(badge)
                        .font(.caption2)
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Color.purple)
                        .clipShape(Circle())
                        .offset(x: 10, y: -10)
                }
            }
            Text(label)
                .font(.caption)
                .foregroundColor(isSelected ? .black : .gray)
        }
    }
}


//#Preview {
//    DashboardView()
//}
