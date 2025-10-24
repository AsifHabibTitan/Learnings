//
//  UserDecisionManager.swift
//  MatchMate
//
//  Created by Asif Habib on 30/07/25.
//

import Foundation

class UserDecisionManager: ObservableObject {
    private let userDefaults = UserDefaults.standard
    private let acceptedUsersKey = "acceptedUsers"
    private let rejectedUsersKey = "rejectedUsers"
    
    @Published var acceptedUsers: Set<String> = []
    @Published var rejectedUsers: Set<String> = []
    
    init() {
        loadDecisions()
    }
    
    // MARK: - Public Methods
    
    func acceptUser(_ user: ProfileModel) {
        acceptedUsers.insert(user.id)
        rejectedUsers.remove(user.id)
        saveDecisions()
    }
    
    func rejectUser(_ user: ProfileModel) {
        rejectedUsers.insert(user.id)
        acceptedUsers.remove(user.id)
        saveDecisions()
    }
    
    func getDecision(for user: ProfileModel) -> Bool? {
        if acceptedUsers.contains(user.id) {
            return true
        } else if rejectedUsers.contains(user.id) {
            return false
        }
        return nil
    }
    
    func clearDecisions() {
        acceptedUsers.removeAll()
        rejectedUsers.removeAll()
        saveDecisions()
    }
    
    // MARK: - Private Methods
    
    private func loadDecisions() {
        if let acceptedData = userDefaults.array(forKey: acceptedUsersKey) as? [String] {
            acceptedUsers = Set(acceptedData)
        }
        
        if let rejectedData = userDefaults.array(forKey: rejectedUsersKey) as? [String] {
            rejectedUsers = Set(rejectedData)
        }
    }
    
    private func saveDecisions() {
        userDefaults.set(Array(acceptedUsers), forKey: acceptedUsersKey)
        userDefaults.set(Array(rejectedUsers), forKey: rejectedUsersKey)
    }
} 
