//
//  WelcomeViewController.swift
//  WeChat
//
//  Created by Asif Habib on 05/04/25.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let title = "WeChat"
        titleLabel.text = ""
        var charIndex = 0.0
        for char in title {
            print(char)
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { timer in
                self.titleLabel.text?.append(char)
            }
            charIndex += 1
        }
        
    }
}
