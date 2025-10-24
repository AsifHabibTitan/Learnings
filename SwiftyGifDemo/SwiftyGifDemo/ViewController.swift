//
//  ViewController.swift
//  SwiftyGifDemo
//
//  Created by Asif Habib on 09/08/23.
//

import UIKit
import SwiftyGif

class ViewController: UIViewController {
    @IBOutlet weak var firstImageView: UIImageView!
    
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var tenthImage: UIImageView!
    @IBOutlet weak var ninethImage: UIImageView!
    @IBOutlet weak var eighthImage: UIImageView!
    @IBOutlet weak var seventhImage: UIImageView!
    @IBOutlet weak var sixthImage: UIImageView!
    @IBOutlet weak var fifthImage: UIImageView!
    @IBOutlet weak var fourthImage: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let gif1 = try UIImage(gifName: "spongebob.gif")
//            let gif2 = try UIImage(gifName: "Second")
            self.firstImageView.setGifImage(gif1, loopCount: -1)
            self.secondImageView.setGifImage(gif1, loopCount: -1)
            self.thirdImageView.setGifImage(gif1, loopCount: -1)
            self.fourthImage.setGifImage(gif1, loopCount: -1)
            self.fifthImage.setGifImage(gif1, loopCount: -1)
            self.sixthImage.setGifImage(gif1, loopCount: -1)
            self.seventhImage.setGifImage(gif1, loopCount: -1)
            self.eighthImage.setGifImage(gif1, loopCount: -1)
            self.ninethImage.setGifImage(gif1, loopCount: -1)
            self.tenthImage.setGifImage(gif1, loopCount: -1)
            self.thirdImage.setGifImage(gif1, loopCount: -1)
        } catch {
            print(error)
        }
        
    }


}

