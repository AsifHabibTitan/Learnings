//
//  ViewController.swift
//  webviewpoc
//
//  Created by Asif Habib on 07/05/25.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    @IBOutlet weak var subView: UIView!
    var webView: WKWebView!
    var helpRequest: URLRequest?
    
    
    @IBAction func reload(_ sender: Any) {
        webView.reload()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
        let helpURL = URL(string:"https://www.google.com")
        if let url = helpURL {
            helpRequest = URLRequest(url: url)
            webView.frame = subView.bounds
                    subView.addSubview(webView)
        //            webView.translatesAutoresizingMaskIntoConstraints = false
        //            NSLayoutConstraint.activate([
        //                webView.leadingAnchor.constraint(equalTo: subView.leadingAnchor),
        //                webView.trailingAnchor.constraint(equalTo: subView.trailingAnchor),
        //                webView.topAnchor.constraint(equalTo: subView.topAnchor),
        //                webView.bottomAnchor.constraint(equalTo: subView.bottomAnchor)
        //            ])
            if let request = helpRequest {
                webView.load(request)
            }
            
        }
        
    }

    func setupWebView() {
    let webConfiguration = WKWebViewConfiguration()
    webView = WKWebView(frame: .zero, configuration: webConfiguration)
    //        webView.uiDelegate = self
    }
}





