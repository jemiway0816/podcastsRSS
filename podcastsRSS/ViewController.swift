//
//  ViewController.swift
//  podcastsRSS
//
//  Created by Jemiway on 2022/9/27.
//

import UIKit
import WebKit


class ViewController: UIViewController {

    var item:Result!
    
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let urlDetail = URL(string: item.url) {
            
            let request = URLRequest(url: urlDetail)
            self.webView.load(request)
        }

    }


}

