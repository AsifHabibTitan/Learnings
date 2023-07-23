//
//  ViewController.swift
//  ProjectOOPs
//
//  Created by Asif Habib on 16/06/23.
//

import UIKit
import Framework2



class ViewController: UIViewController {

    override func viewDidLoad() {
        print("viewdidload")
        super.viewDidLoad()
        debugPrint("ViewDId Load")
        
//        let st = Student()
////        print(st.age)
//        print(st.getStudent())
        // Do any additional setup after loading the view.
        
        
        
    }
    @IBAction func redVC(_ sender: Any) {
        let vc = ColorViewController()
//        vc.modalTransitionStyle = .flipHorizontal
//        vc.modalPresentationStyle = .fullScreen
        vc.view.backgroundColor = UIColor.red;
        present(vc, animated: true, completion: nil)
    }
    @IBAction func orangeVC(_ sender: Any) {
        let vc = ColorViewController()
        vc.view.backgroundColor = UIColor.orange;
        present(vc, animated: true, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        print("view appeared")
        debugPrint("View did appear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("View going to disappear")
        debugPrint("View will disappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("View disappeared")
        debugPrint("ViewDidDisappear")
//        UIApplication.shared.open(
        let instagramHooks = "instagram://user?username=johndoe"
        let instagramUrl = URL(string: instagramHooks)!
        if UIApplication.shared.canOpenURL(instagramUrl)
        {
            UIApplication.shared.open(instagramUrl)
        } else {
            //redirect to safari because the user doesn't have Instagram
            UIApplication.shared.open(URL(string:"http://instagram.com/")!)
        }
    }

}

