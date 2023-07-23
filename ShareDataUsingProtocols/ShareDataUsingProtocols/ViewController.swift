//
//  ViewController.swift
//  ShareDataUsingProtocols
//
//  Created by Asif Habib on 13/07/23.
//

import UIKit
struct Vendor {
    var name: String
    var product: String
    init(name: String, product: String) {
        self.name = name
        self.product = product
    }
}
enum VendorType {
    case Linware, Ido, Yawell
}
enum FeatureType {
    case Steps, Sleep, HeartRate, SpO2, Temperature
}


class ViewController: UIViewController {
    
    @IBOutlet weak var vendorOutlet: UISegmentedControl!
    @IBOutlet weak var Result: UILabel!
    @IBOutlet weak var featureOutlet: UISegmentedControl!
    var delegate: VendorDelegate?
    
    

    @IBAction func FeatureSelector(_ sender: UISegmentedControl) {
        updateLabel()
        
    }
    
    @IBAction func VendorSelector(_ sender: UISegmentedControl) {
        self.setVendor(index: sender.selectedSegmentIndex)
        updateLabel()
    }
    
    func updateLabel() {
        let data = getData(index: featureOutlet.selectedSegmentIndex)
        Result.text! = String(data)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        vendorOutlet.selectedSegmentIndex = UISegmentedControl.noSegment
        featureOutlet.selectedSegmentIndex = UISegmentedControl.noSegment
    }

    
    
    func setVendor(index: Int)  {
        switch index {
        case 0:
             TitanWatch.current = Linwear()
        case 1:
            TitanWatch.current = Ido()
        case 2:
            TitanWatch.current = Yawell()
        default:
            break
        }
    }
    
    func getData(index: Int)-> Int {
        switch index {
        case 0:
            return TitanWatch.current.getSteps()
        case 1:
            return TitanWatch.current.getSleepData()
        case 2:
            return TitanWatch.current.getHeartRate()
        case 3:
            return TitanWatch.current.getSpO2()
        case 4:
            return TitanWatch.current.getTemprature()
        default:
            return 0
        }
    }

}

//class SecondVC: UIViewController{
//    func changeVendor() {
//        TitanWatch.current = Linwear()
//    }
//}
//
//class SecondVC1: UIViewController{
//    func changeVendor() {
//        TitanWatch.current = Ido()
//    }
//}
//
//class SecondVC3: UIViewController{
//
//}
//
//class SecondVC6: UIViewController{
//
//}


