//
//  MatchesViewModel.swift
//  MatchMate
//
//  Created by Asif Habib on 30/07/25.
//
import Foundation

class MatchesViewModel: ObservableObject {
    @Published var profiles: [UserModel] = []
    init() {
//        fetchMatches()
    }
    
    func fetchMatches() {

        APIService.shared.get(
            .profiles,
            headers: [:],
            responseType: [UserModel].self
        ) { result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let decoded):
                    self.profiles = decoded

                case .failure(let error):
                    print("DEBUG: Failed to fetch matches:", error)
//                    self.errorMessage = "Failed to fetch: \(error.localizedDescription)"
                }
            }
        }
    }
    
}
