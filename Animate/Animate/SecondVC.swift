//
//  SecondVC.swift
//  Animate
//
//  Created by Asif Habib on 28/06/25.
//

import Foundation
import UIKit

class SecondVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("secondvc")
    }
    
    @IBAction func goBackButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
