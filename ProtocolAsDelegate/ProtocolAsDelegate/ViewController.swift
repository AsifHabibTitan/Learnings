//
//  ViewController.swift
//  ProtocolAsDelegate
//
//  Created by Asif Habib on 10/07/23.
//

import UIKit

protocol AdvanceHealthSupport {
    func performCPR()
}

class EmergencyHandler {
    var delegate: AdvanceHealthSupport?
    func handleEmergency() {
        delegate?.performCPR()
    }
}
class Paramedic: AdvanceHealthSupport {
    init(handler: EmergencyHandler) {
        handler.delegate = self
    }
    func performCPR() {
        print("Performing cpr")
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let emergencyHandler = EmergencyHandler()
        let paramedic = Paramedic(handler: emergencyHandler)
        emergencyHandler.handleEmergency()
        
        
        
        
        var urlString = "https://api.publicapis.org/entries?title=cat"
        var url = URL(string: urlString)
        var session = URLSession(configuration: .default)
        var task = session.dataTask(with: url!, completionHandler: handleCompletion(data:urlResponse:err:))
        task.resume()
    }
    
    func handleCompletion(data: Data?, urlResponse: URLResponse?, err: Error?) {
        print("handleCompletion called ")
        if let safeData = data {
            var stringifiedData = String(data: safeData, encoding: .utf8)!
            let jsonData = stringifiedData.data(using: .utf8)!
//            let blogPost = try! JSONDecoder().decode(String, from: jsonData)

            print(stringifiedData)
        }
        if let error = err {
            print(error)
        }
    }
   

}

