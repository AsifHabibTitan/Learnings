//
//  ColorViewController.swift
//  ProjectOOPs
//
//  Created by Asif Habib on 16/06/23.
//

import Foundation
import UIKit

class ColorViewController : UIViewController {
    var label : UILabel!
    var color: UIColor?
    var name: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color
        label = UILabel();
        label.text = name
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("View will be appearing shortly")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("View appeared")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("View is going to be removed")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        print("View removed")
    }
    
    func setColor(color: UIColor, name: String) {
        self.color = color
        self.name = name
        
    }
}
