//
//  VideoPlayManager.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/07/18.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class VideoPlayManager: NSObject {
   
    static let sharedManager = VideoPlayManager()
    var videoPlayerViewController: XCDYouTubeVideoPlayerViewController?
    
    override init() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        } catch _ {
        }
        do {
            try audioSession.setActive(true)
        } catch _ {
        }
        
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
    }
    
    func setVideoPlayer(videoID videoID: String, playerView: UIView) {
        videoPlayerViewController = XCDYouTubeVideoPlayerViewController(videoIdentifier: videoID);
        
        videoPlayerViewController!.moviePlayer.backgroundPlaybackEnabled = true
        videoPlayerViewController!.presentInView(playerView);
        videoPlayerViewController!.moviePlayer.controlStyle = MPMovieControlStyle.Embedded
        videoPlayerViewController!.moviePlayer.play()
    }
    
    func setPlayingInfo(title title: String) {
        MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = [MPMediaItemPropertyArtist : "松本人志の放送室",  MPMediaItemPropertyTitle : title]
    }
    
    func remoteControlReceivedWithEvent(event: UIEvent) {
        
        if event.type == UIEventType.RemoteControl {
            switch event.subtype {
            case UIEventSubtype.RemoteControlPlay:
                print("play")
                videoPlayerViewController?.moviePlayer.play()
            case UIEventSubtype.RemoteControlPause:
                print("stop")
                videoPlayerViewController?.moviePlayer.pause()
            case UIEventSubtype.RemoteControlTogglePlayPause:
                print("TogglePlayPause")
            default:
                print("default")
                break
            }
        }
    }
    
}
