//
//  DetailViewController.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/06/11.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {
    @IBOutlet weak var playerView: UIView!
    var videoId = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackButton()
        
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayback, error: nil)
        audioSession.setActive(true, error: nil)
        
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        var newTaskId = UIBackgroundTaskInvalid
        newTaskId = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({ () -> Void in
            return
        })
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
        
//        let idVideo = "tNT6M-SHuhI"
        var videoPlayerViewController: XCDYouTubeVideoPlayerViewController = XCDYouTubeVideoPlayerViewController(videoIdentifier: videoId);
        
        videoPlayerViewController.moviePlayer.backgroundPlaybackEnabled = true
        videoPlayerViewController.presentInView(playerView);
        videoPlayerViewController.moviePlayer.controlStyle = MPMovieControlStyle.Embedded
        videoPlayerViewController.moviePlayer.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
