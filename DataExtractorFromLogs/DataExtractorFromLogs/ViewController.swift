//
//  ViewController.swift
//  DataExtractorFromLogs
//
//  Created by Asif Habib on 17/04/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func extractButton(_ sender: UIButton) {
//        let logsFilePath = Bundle.main.path(forResource: "logs", ofType: "txt")
//        if let path = logsFilePath {
//            let logsFilePathUrl = URL(fileURLWithPath: path)
//            var logsStr = String()
//            do {
//                let data = try String(contentsOf: logsFilePathUrl, encoding: .utf8)
//                logsStr = data
//            } catch {
//                print("ERROR ", error)
//            }
//            
//            
//            let lines = logsStr.split(separator: "\n")
//            var reqStrings = [String]()
//            var hexDataString = String()
//
//            lines.forEach { line in
//                if let lastSemiColonIndex =  line.lastIndex(of: ":") {
//                    let requiredStr = line.suffix(from: line.index(after: lastSemiColonIndex))
//                    reqStrings.append(String(requiredStr))
//                }
//                
//            }
//            print("REquired Strings ", reqStrings)
//            reqStrings.forEach { dataStr in
//                var hexData = String()
//                dataStr.split(separator: ",").forEach { char in
//                    let whitespaceRemovedChar = char.trimmingCharacters(in: .whitespaces)
//                    hexData += "0x\(whitespaceRemovedChar), "
//                }
//                hexData += "\n"
//                hexDataString += hexData
//            }
//
//            print(hexDataString)
//        }
        self.extractButton2()
        
    }
    
    func extractButton2() {
        let logsFilePath = Bundle.main.path(forResource: "logs", ofType: "txt")
        if let path = logsFilePath {
            let logsFilePathUrl = URL(fileURLWithPath: path)
            var logsStr = String()
            do {
                let data = try String(contentsOf: logsFilePathUrl, encoding: .utf8)
                logsStr = data
            } catch {
                print("ERROR ", error)
            }
            
            
            let lines = logsStr.split(separator: "\n")
            var reqStrings = [String]()
            var HEXVALUES = [[UInt8]]()
            lines.forEach { line in
                if let lastSemiColonIndex =  line.lastIndex(of: ":") {
                    let requiredStr = line.suffix(from: line.index(after: lastSemiColonIndex))
                    reqStrings.append(String(requiredStr))
                }
                
            }
            
            reqStrings.forEach { dataStr in
                var hexDD = [UInt8]()
                dataStr.split(separator: ",").forEach { char in
                    let whitespaceRemovedChar = char.trimmingCharacters(in: .whitespaces)
                    if let uintValue = UInt8(whitespaceRemovedChar, radix: 16) {
                        hexDD.append(uintValue)
                    }
                    
                }
                HEXVALUES.append(hexDD)
                
            }

            print(HEXVALUES)
        }
        
        
    }
}


