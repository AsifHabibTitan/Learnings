//
//  UserListView.swift
//  MVVMTest
//
//  Created by Asif Habib on 15/09/25.
//
import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel: UserListViewModel
    var body: some View {
        if viewModel.users.isEmpty {
            Text(viewModel.errorString)
        } else {
            List(viewModel.users, id: \.email) { user in
                HStack {
                    
                    Text("\(user.name)")
                    Spacer()
                    Text("\(user.email)")
                }
                
            }
            
        }
        
    }
}

#Preview {
    UserListView(viewModel: .init(repository: UserRepository(apiService: APIService.shared, dbService: DatabaseService())))
}
