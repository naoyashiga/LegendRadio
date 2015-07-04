//
//  HousoushitsuObjectHandler.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/06/08.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import Foundation
import UIKit

class HousoushitsuObjectHandler {
    
//    class func asyncLoadShotImage(shot: Story, imageView: UIImageView){
//        let downloadQueue = dispatch_queue_create("com.naoyashiga.processdownload", nil)
//        
//        dispatch_async(downloadQueue){
//            var data = NSData(contentsOfURL: NSURL(string: shot.imageUrl)!)
//            
//            var image: UIImage?
//            var sdImageView: UIImageView?
//            
//            if data != nil {
//                shot.imageData = data
//                image = UIImage(data: data!)!
//            }
//            
//            dispatch_async(dispatch_get_main_queue()){
//                imageView.image = image
//            }
//        }
//    }
    
    class func getStories(url: String, callback:(([Story]) -> Void)){
        var stories = [Story]()
        println(url)
        
        HttpService.getJSON(url){ (jsonData) -> Void in
            
            for storyData in jsonData {
                let story = Story(data: storyData as! NSDictionary)
                stories.append(story)
            }
            
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0), { () -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    callback(stories)
                })
            })
        }
    }
}