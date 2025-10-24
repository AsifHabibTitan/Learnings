//
//  MainTabView.swift
//  MatchMate
//
//  Created by Asif Habib on 30/07/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Text("Home")
                .tabItem{TabButton(image: "house.fill", label: "Home")}
            MatchesView()
                .tabItem{ TabButton(image: "person.2", label: "Matches") }
            Text("Inbox")
                .tabItem{ TabButton(image: "envelope", label: "Inbox") }
            Text("Chat")
                .tabItem{ TabButton(image: "message", label: "Chat") }
            Text("Premium")
                .tabItem{ TabButton(image: "crown", label: "Premium")}
        }
        .tint(Color(red: 253/255, green: 92/255, blue: 101/255))
    }
}

struct TabButton: View {
    var image: String
    var label: String
    var body: some View {
        VStack{
            Image(systemName: image)
            Text(label)
        }
        
    }
}

#Preview {
    MainTabView()
}
