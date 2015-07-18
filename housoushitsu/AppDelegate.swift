//
//  AppDelegate.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/06/08.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let font = UIFont(name: "AxisStd-Bold", size: 18)
        if let font = font {
            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName : font, NSForegroundColorAttributeName : UIColor.navigationTitleColor()]
        }
        
        UITabBar.appearance().tintColor = UIColor.tabBarItemTintColor()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayback, error: nil)
        audioSession.setActive(true, error: nil)
        
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }
    
    override func remoteControlReceivedWithEvent(event: UIEvent) {
        VideoPlayManager.sharedManager.remoteControlReceivedWithEvent(event)
    }
}

