//
//  CLEAN1App.swift
//  CLEAN1
//
//  Created by Asif Habib on 05/09/25.
//

import SwiftUI

@main
struct CLEAN1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            UserListView(viewModel: CLEAN1App.makeUserListViewModel())
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    private static func makeUserListViewModel() -> UserListViewModel {
        let networkManager = NetworkManager()
        let repository = UserRepositoryImpl(networkManager: networkManager)
        let useCase = FetchUsersUseCaseImpl(repository: repository)
        return UserListViewModel(fetchUsersUseCase: useCase)
    }
}
