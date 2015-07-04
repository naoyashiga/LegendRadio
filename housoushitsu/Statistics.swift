//
//  Statistics.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/07/04.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import Foundation

class Statistics: HousoushitsuBase {
    var viewCount = ""
    var likeCount = ""
    
    override init(data: NSDictionary) {
        super.init(data: data)
        let contentsDetails = data["statistics"] as! NSDictionary
        viewCount = contentsDetails.valueForKeyPath("viewCount") as! String
        likeCount = contentsDetails.valueForKeyPath("likeCount") as! String
    }
}