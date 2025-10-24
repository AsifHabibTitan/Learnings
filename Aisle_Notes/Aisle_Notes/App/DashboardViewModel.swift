//
//  DashboardViewModel.swift
//  Aisle_Notes
//
//  Created by Asif Habib on 17/07/25.
//

import Foundation
import UIKit
import SwiftUI

class DashboardViewModel: ObservableObject {
    @Published var inviteProfiles: [Profile] = []
    @Published var likeProfiles: [LikeProfile] = []
    @Published var canSeeLikes: Bool = false
    @Published var pendingNoteCount: Int = 0

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func fetchNotes() {
        isLoading = true
        errorMessage = nil

        let token = UserDefaults.standard.string(forKey: "authToken") ?? ""

        APIService.shared.get(
            .testProfileList,
            headers: [
                "Authorization": token,
                "Content-Type": "application/json"
            ],
            responseType: APIResponse.self
        ) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let decoded):
                    self.inviteProfiles = decoded.invites.profiles
                    self.pendingNoteCount = decoded.invites.pendingInvitationsCount
                    self.likeProfiles = decoded.likes.profiles
                    self.canSeeLikes = decoded.likes.canSeeProfile

                case .failure(let error):
                    self.errorMessage = "Failed to fetch: \(error.localizedDescription)"
                }
            }
        }
    }
}

