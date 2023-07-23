//
//  ViewController.swift
//  Xylophone
//
//  Created by Asif Habib on 07/07/23.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    var player : AVAudioPlayer?
    @IBAction func ClickButton(_ sender: UIButton) {
        print("clicked", sender.titleLabel?.text!)
        if let f = sender.titleLabel?.text{
            print(f)
            playSound(f)
        }
        
        sender.alpha = 0.5
        print("sleelings")
        sleep(2)
        
        print("something")
//        sender.alpha = 1
//
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func playSound(_ fileName: String) {
        print("got filename as \(fileName)")
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "wav")
        else{
            return
        }
        
        do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)

                /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)

                /* iOS 10 and earlier require the following line:
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

                guard let player = player else { return }
                print(player)
                player.play()

            } catch let error {
                print(error.localizedDescription)
            }
        
        print(url)
    }
}

