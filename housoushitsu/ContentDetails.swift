//
//  ContentDetails.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/07/04.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import Foundation

class ContentDetails: HousoushitsuBase {
    var duration = ""
    
    override init(data: NSDictionary) {
        super.init(data: data)
//        let contentsDetails = data["contentDetails"] as! NSDictionary
        
        if let contentsDetails = data["contentDetails"] as? NSDictionary {
            if let d = contentsDetails.valueForKeyPath("duration") as? String {
                duration = d
            }
        }
    }
}