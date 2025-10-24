//
//  ContentView.swift
//  TestList
//
//  Created by Asif Habib on 05/09/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: UserViewModel
    
    var body: some View {
//        List(viewModel.users, id:\.id) {user in
//            Text( user.title )
//        }
        OTPTest()
    }
    private static func makeVM() -> UserViewModel{
        let networkRepo = NetworkRepository()
        return UserViewModel(repo: networkRepo)
    }
}

//#Preview {
//    ContentView(viewModel: )
//}
