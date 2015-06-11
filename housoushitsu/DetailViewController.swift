//
//  DetailViewController.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/06/11.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.loadHTMLString("<html><body style=\"(margin:0)\"><embed src=\"https://www.youtube.com/embed/tNT6M-SHuhI?rel=0&amp;showinfo=0\" frameborder=\"0\"></embed></body></html>", baseURL: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
