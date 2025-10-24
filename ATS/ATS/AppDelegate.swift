//
//  AppDelegate.swift
//  ATS
//
//  Created by Asif Habib on 15/02/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if isJailbroken() {
            print("JAILBROKEN")
            exit(0)
        } else {
            print("NOT JAILBROKEN")
        }
        return true
    }

    // MARK: UISceneSession Lifecycle
    func isJailbroken() -> Bool {
        let fileManager = FileManager.default
        
        // Check for the existence of Cydia
        if fileManager.fileExists(atPath: "/Applications/Cydia.app") {
            return true
        }
        let jailbreakAppPaths = [
            "/Applications/Cydia.app",
            "/Applications/Sileo.app",
            "/Applications/Zebra.app"
        ]
        
        for path in jailbreakAppPaths {
            if fileManager.fileExists(atPath: path) {
                print("PATH: ", path)
                return true
            }
        }
        // Check for the presence of certain file paths commonly found in jailbroken devices
        let jailbreakFilePaths = [
            "/etc/apt",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/private/var/lib/apt/",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
        ]
        
        for path in jailbreakFilePaths {
            if fileManager.fileExists(atPath: path) {
                print("PATH: ", path)
                return true
            }
        }
        
        // Check for sandbox integrity
        if UIApplication.shared.canOpenURL(URL(string: "cydia://package/com.example.package")!) {
            return true
        }
        
        return false
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

