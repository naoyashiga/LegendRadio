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
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayback, error: nil)
        audioSession.setActive(true, error: nil)
        
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
    }
    
    func setVideoPlayer(#videoID: String, playerView: UIView) {
        videoPlayerViewController = XCDYouTubeVideoPlayerViewController(videoIdentifier: videoID);
        
        videoPlayerViewController!.moviePlayer.backgroundPlaybackEnabled = true
        videoPlayerViewController!.presentInView(playerView);
        videoPlayerViewController!.moviePlayer.controlStyle = MPMovieControlStyle.Embedded
        videoPlayerViewController!.moviePlayer.play()
    }
    
    func setPlayingInfo(#title: String) {
        MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = [MPMediaItemPropertyArtist : "松本人志の放送室",  MPMediaItemPropertyTitle : title]
    }
    
    func remoteControlReceivedWithEvent(event: UIEvent) {
        
        if event.type == UIEventType.RemoteControl {
            switch event.subtype {
            case UIEventSubtype.RemoteControlPlay:
                println("play")
                videoPlayerViewController?.moviePlayer.play()
            case UIEventSubtype.RemoteControlPause:
                println("stop")
                videoPlayerViewController?.moviePlayer.pause()
            case UIEventSubtype.RemoteControlTogglePlayPause:
                println("TogglePlayPause")
            default:
                println("default")
                break
            }
        }
    }
    
}
