//
//  ContentView.swift
//  MVVMTest
//
//  Created by Asif Habib on 15/09/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        UserListView(viewModel: .init(repository: UserRepository(apiService: APIService.shared, dbService: DatabaseService())))
    }
}

#Preview {
    ContentView()
}
