//
//  DetailViewController.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/06/11.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var playerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackButton()
        
//        webView.loadHTMLString("<html><body style=\"(margin:0)\"><embed src=\"https://www.youtube.com/embed/tNT6M-SHuhI?rel=0&amp;showinfo=0\" frameborder=\"0\"></embed></body></html>", baseURL: nil)
        
//        let mainPlayerViewFrame: CGRect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height / 3)
//        let mainPlayerView: UIView = UIView(frame: mainPlayerViewFrame)
//        self.view.addSubview(mainPlayerView)
        

    }
    
    func setBackButton() {
        let backButton = UIBarButtonItem(title: "< 戻る", style: UIBarButtonItemStyle.Plain, target: self, action: "goBack")
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AxisStd-Medium", size: 15)!], forState: UIControlState.Normal)
    }
    
    func goBack() {
        navigationController?.popViewControllerAnimated(true)
    }

    override func viewDidAppear(animated: Bool) {
//        let mainPlayerViewFrame: CGRect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height / 3)
//        let mainPlayerView: UIView = UIView(frame: mainPlayerViewFrame)
//        self.view.addSubview(mainPlayerView)
        
        let idVideo = "tNT6M-SHuhI"
        var videoPlayerViewController: XCDYouTubeVideoPlayerViewController = XCDYouTubeVideoPlayerViewController(videoIdentifier: idVideo);
//        videoPlayerViewController.presentInView(mainPlayerView);
        videoPlayerViewController.presentInView(playerView);
        videoPlayerViewController.moviePlayer.controlStyle = MPMovieControlStyle.Embedded
        videoPlayerViewController.moviePlayer.play()
//        self.view.addSubview(videoPlayerViewController.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
