//
//  ViewController.swift
//  GCD
//
//  Created by Asif Habib on 17/04/25.
//

import UIKit

class ViewController: UIViewController {
    let numberSemaphore = DispatchSemaphore(value: 0)
    let alphaSemaphore = DispatchSemaphore(value: 0)
    let alphabetQueue = DispatchQueue(label: "alphabetQueue")
    let numberQueue = DispatchQueue(label: "numberQueue")
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        runFunc()
        printString()
    }

    func runFunc() {
        let operation1 = BlockOperation {
            print("operation1 started...")
            sleep(4)
            print("operation1 finished...")
            
        }
        let operation2 = BlockOperation {
            print("operation2 started...")
            sleep(4)
                print("operation2 finished...")
            
        }
        operation1.addDependency(operation2)
        let queue = OperationQueue()
        queue.addOperation(operation1)
        queue.addOperation(operation2)
//        queue.
        
    }
    
    func printNumbers() {
        for i in 1...26 {
            numberSemaphore.wait()
            print(i, terminator: ",")
//            alphaSemaphore.signal()
        }
        
    }
    func printAlpha() {
        for i in 0..<26 {
//            alphaSemaphore.wait()
            print(Unicode.Scalar(65 + i) ?? "", terminator: ",")
            numberSemaphore.signal()
        }
    }
    
    func printString() {
        numberQueue.async{
            self.printNumbers()
        }
        alphabetQueue.async{
            self.printAlpha()
        }
  
    }
    
}

