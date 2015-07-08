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
    
    class func getContentDetails(url: String, callback:(([ContentDetails]) -> Void)){
        var contentDetails = [ContentDetails]()
        
        HttpService.getJSON(url){ (jsonData) -> Void in
            for contentDetailsData in jsonData {
                let duration = ContentDetails(data: contentDetailsData as! NSDictionary)
                contentDetails.append(duration)
            }
            
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0), { () -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    callback(contentDetails)
                })
            })
        }
    }
    
    class func getStatistics(url: String, callback:(([Statistics]) -> Void)){
        var statistics = [Statistics]()
        
        HttpService.getJSON(url){ (jsonData) -> Void in
            for statisticsData in jsonData {
                let result = Statistics(data: statisticsData as! NSDictionary)
                statistics.append(result)
            }
            
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0), { () -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    callback(statistics)
                })
            })
        }
    }
}