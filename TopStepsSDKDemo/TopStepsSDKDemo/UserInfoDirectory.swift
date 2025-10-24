//
//  UserInfoDirectory.swift
//  BLEDemoApp
//
//  Created by Shreya Naik on 30/08/23.
//

import Foundation

class UserLogs{
    static let sharedDirectory = UserLogs()
    
    func createLogDirectory()-> URL? {
        
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let userDirectory = documentsDirectory.appendingPathComponent("UserInfoLogs", isDirectory: true)
        if fileManager.fileExists(atPath: userDirectory.path){
            do {
                try fileManager.createDirectory(at: userDirectory, withIntermediateDirectories: true, attributes: nil)
                print("User directory created at: \(userDirectory.path)")
                return userDirectory
            } catch {
                print("Error creating directory: \(error)")
                return nil
            }
        }else{
            print( "created directory")
            return userDirectory
        }
    }
    
    func addTxtFileForUserInfo(){
        let userDirectory = createLogDirectory()
        let filePath = userDirectory?.appendingPathComponent("user.txt")
        let userInfo = "Name: John Doe\nEmail: johndoe@example.com"
        do {
            try userInfo.write(to: filePath!, atomically: true, encoding: .utf8)
            print("User info saved to file: \(filePath!.path)")
        } catch {
            print("Error writing to file: \(error)")
        }
    }
    func removeTextFile(){
        let userDirectory = createLogDirectory()
        let filePath = userDirectory?.appendingPathComponent("user.txt")
        if FileManager.default.fileExists(atPath: userDirectory!.path){
            do {
                try FileManager.default.removeItem(at: filePath!)
                print("User info removed at Path: \(filePath!.path)")
            } catch {
                print("Error while deleting file: \(error)")
            }
        }
        
    }
}
