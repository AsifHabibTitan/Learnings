//
//  ViewController.swift
//  test
//
//  Created by Asif Habib on 11/11/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .red
        button.layer.borderWidth = 3
        button.wid
        button.layer.cornerRadius = 44
        button.layer.backgroundColor = .init(gray: 44, alpha: 1)
        button.layer.shadowColor = .init(red: 44, green: 76, blue: 34, alpha: 1)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 5
      
    }
    @IBOutlet weak var button: UIButton!
    

}

