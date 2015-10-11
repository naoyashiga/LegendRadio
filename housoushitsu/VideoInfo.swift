//
//  VideoInfo.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/07/06.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import Foundation
import UIKit

class VideoInfo {
    class func getDurationTimes(videoID: String, callback:(([ContentDetails]) -> Void)) {
        let contentsDetailURL = Config.REQUEST_CONTENT_DETAILS_URL + "id=\(videoID)"
        
        HousoushitsuObjectHandler.getContentDetails(contentsDetailURL, callback: {(contentDetails) -> Void in
            callback(contentDetails)
        })
    }
    
    class func getStatistics(videoID: String, callback:(([Statistics]) -> Void)) {
        let statisticsURL = Config.REQUEST_STATISTICS_URL + "id=\(videoID)"
        
        HousoushitsuObjectHandler.getStatistics(statisticsURL, callback: {(statistics) -> Void in
            callback(statistics)
        })
    }
    
    class func getDurationStr(nonFormatStr: String) -> String {
        let pH = "H"
        let pM = "M"
        let pS = "S"
        
        let pattern = "[PT|S]"
        
        let rH = "時間"
        let rM = "分"
        let rS = "秒"
        let replace = ""
        
        var replaceString = doReplace(str: nonFormatStr, pattern: pH, replaceStr: rH)
        replaceString = doReplace(str: replaceString, pattern: pM, replaceStr: rM)
        replaceString = doReplace(str: replaceString, pattern: pS, replaceStr: rS)
        replaceString = doReplace(str: replaceString, pattern: pattern, replaceStr: replace)
        
        return replaceString
    }
    
    class func doReplace(str str:String, pattern: String, replaceStr: String) -> String {
        return str.stringByReplacingOccurrencesOfString(pattern, withString: replaceStr, options: NSStringCompareOptions.RegularExpressionSearch, range: nil)
        
    }
}