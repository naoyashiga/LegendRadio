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
    var videoTitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackButton()
        
//        var newTaskId = UIBackgroundTaskInvalid
//        newTaskId = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({ () -> Void in
//            return
//        })
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
        
        VideoPlayManager.sharedManager.setVideoPlayer(videoID: videoId, playerView: playerView)
        VideoPlayManager.sharedManager.setPlayingInfo(title: videoTitle)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
