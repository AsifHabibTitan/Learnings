//
//  TestListApp.swift
//  TestList
//
//  Created by Asif Habib on 05/09/25.
//

import SwiftUI

@main
struct TestListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: TestListApp.makeVM())
        }
    }
    
    private static func makeVM() -> UserViewModel{
        let networkRepo = NetworkRepository()
        return UserViewModel(repo: networkRepo)
    }
}
