//
//  ViewController.swift
//  ATS
//
//  Created by Asif Habib on 15/02/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var request = URLRequest(url: URL(string: "http://dummyjson.com/products/1")!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            // Handle response
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            
            // Handle data
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response: \(jsonString)")
                } else {
                    print("Unable to convert data to string")
                }
            } else {
                print("No data received")
            }
        }

        // Start the data task
        task.resume()
    }


}

