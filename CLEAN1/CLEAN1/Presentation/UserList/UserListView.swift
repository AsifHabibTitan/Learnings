//
//  UserListView.swift
//  CLEAN
//
//  Created by Asif Habib on 05/09/25.
//

import Foundation
import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel: UserListViewModel

    init(viewModel: UserListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        List(viewModel.users) { user in
            VStack(alignment: .leading) {
                Text(user.name)
                Text(user.email).font(.subheadline)
            }
        }
        .onAppear { viewModel.fetchUsers() }
        .overlay(
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)").foregroundColor(.red)
                }
            }
        )
    }
}

//struct UserListView_Previews: PreviewProvider {
//    static var previews: some View {
//        let mockRepo = MockUserRepository()
//        let mockUseCase = FetchUsersUseCase(repository: mockRepo)
//        let mockVM = UserListViewModel(fetchUsersUseCase: mockUseCase)
//        UserListView(viewModel: mockVM)
//    }
//}
