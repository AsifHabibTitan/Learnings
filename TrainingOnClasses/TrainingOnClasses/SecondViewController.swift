//
//  SecondViewController.swift
//  TrainingOnClasses
//
//  Created by Asif Habib on 27/06/23.
//

import UIKit

class Student {
    func func1 () {
        print(#function)
    }
    static func func2(){
        print(#function)
    }
    class func func3(){ // class method behaves same as static method
        print(#function)
    }
    
}
 func toString(_ anything: Any?) -> String {
    if let any = anything {
        if let num = any as? NSNumber {
            return num.stringValue
        } else if let str = any as? String {
            return str
        }
    }
    return ""

}
class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var student = Student()
        student.func1()
        Student.func2()
        Student.func3()
        
        var v = NSExpression(format: "125/12")
        let result = v.expressionValue(with: nil, context: nil)!
        debugPrint(result)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
