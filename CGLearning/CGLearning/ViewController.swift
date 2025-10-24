//
//  ViewController.swift
//  CGLearning
//
//  Created by Asif Habib on 21/06/25.
//

import UIKit

class ViewController: UIViewController {
    var currentGraphicsNumber: Int = 0
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        drawRectangle()
    }

    @IBAction func redrawTapped(_ sender: UIButton) {
        currentGraphicsNumber += 1
        print("screen", currentGraphicsNumber)
        switch currentGraphicsNumber {
        case 1:
            drawRectangle()
        case 2:
            drawCircle()
        case 3:
            drawCheckeredBox()
        case 4:
            drawRotatedSquares()
        case 5:
            drawLines()
        default:
            currentGraphicsNumber = 0
            
        }
    }
    
    func drawRectangle() {
        // begin image context
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 512, height: 512), false, 0)
        let context = UIGraphicsGetCurrentContext()
        let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
        context?.setFillColor(UIColor.red.cgColor)
        context?.setStrokeColor(UIColor.black.cgColor)
        context?.setLineWidth(10)       // width of stroke, appears to be 5. as half on both sides of borderline
        context?.addRect(rectangle)
        context?.drawPath(using: .fillStroke)       // draw according to all the above specificatoins
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imageView.image = img
    }
    
    func drawCircle() {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 512, height: 512), false, 1)
        let context = UIGraphicsGetCurrentContext()
        let rectangle = CGRect(x: 5, y: 5, width: 502, height: 502)
        context?.addEllipse(in: rectangle)
        context?.setFillColor(UIColor.red.cgColor)
        context?.setStrokeColor(UIColor.green.cgColor)
        context?.setLineWidth(10)
        context?.drawPath(using: .fillStroke)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imageView.image = img
    }
    
    func drawCheckeredBox() {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 512, height: 512), false, 1)
        let context = UIGraphicsGetCurrentContext()
//        let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
        for row in 0..<8 {
            for col in 0..<8 {
                if row.isMultiple(of: 2) {
                    if col.isMultiple(of: 2) {
                        print("*", row, col)
                        let rectangle = CGRect(x: col*64, y:  row*64, width: 64, height: 64)
                        context?.setFillColor(UIColor.blue.cgColor)
                        context?.addRect(rectangle)
                    }
                    
                } else {
                    if !col.isMultiple(of: 2) {
                        print(">", row, col)
                        let rectangle = CGRect(x: col*64, y: row*64, width: 64, height: 64)
                        context?.setFillColor(UIColor.yellow.cgColor)
                        context?.addRect(rectangle)
                    }
                }
                
            }
        }
        
        context?.drawPath(using: .fillStroke)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imageView.image = img
    }
    
    func drawRotatedSquares() {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 512, height: 512), false, 1)
        let context = UIGraphicsGetCurrentContext()
        
        context!.translateBy(x: 256, y: 256)
        let rotations = 16
        let amount = M_PI_2 / Double(rotations)
        
        for i in 0..<rotations {
            context?.rotate(by: CGFloat(amount))
            let rectangle = CGRect(x: -128, y: -128, width: 256, height: 256)
            context?.addRect(rectangle)
            
        }
        context?.setStrokeColor(UIColor.red.cgColor)
        context?.strokePath()
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imageView.image = img
    }
    
    func drawLines() {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 512, height: 512), false, 1)
        let context = UIGraphicsGetCurrentContext()
        
        context!.translateBy(x: 256, y: 256)
        var isFirst = true
        var length:CGFloat = 256.0
        
        for i in 0..<256 {
            context?.rotate(by: M_PI_2)
            if isFirst {
                context?.move(to: CGPoint(x: CGFloat(length), y: 50))
                isFirst = false
                
            } else {
                context?.addLine(to:CGPoint(x: length, y: 50))
            }
            length *= 0.99
            
        }
        context?.setStrokeColor(UIColor.red.cgColor)
        context?.strokePath()
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imageView.image = img
    }
}

