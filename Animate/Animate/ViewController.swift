//
//  ViewController.swift
//  Animate
//
//  Created by Asif Habib on 28/06/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = UIImage(named: "Circular")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewController viewDidAppear called")
        startRotationAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ViewController viewWillDisappear called")
        // Stop any ongoing animations
        imageView.layer.removeAllAnimations()
    }
    
    private func startRotationAnimation() {
        print("Starting rotation animation")
        // Reset transform first
        imageView.transform = .identity
        
        UIView.animate(withDuration: 1.5, delay: 0, options: [.curveLinear, .repeat], animations: {
            self.imageView.transform = CGAffineTransform(rotationAngle: .pi)
        }, completion: { _ in
            print("Animation completed")
        })
    }

    @IBAction func changeVC(_ sender: Any) {
        let secondVC = SecondVC(nibName: "SecondVC", bundle: nil)
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
}

