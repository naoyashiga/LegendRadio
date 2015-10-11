//
//  Story.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/06/08.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import Foundation

class Story: HousoushitsuBase {
    var title = ""
    var url = ""
    var videoId = ""
    
    override init(data: NSDictionary) {
        super.init(data: data)
        
        if let snippet = data["snippet"] as? NSDictionary {
            title = Utils.getStringFromJSON(snippet, key: "title")
            if let str = snippet.valueForKeyPath("thumbnails.default.url") as? String {
                url = str
            }
        }
        
        if let id = data["id"] as? NSDictionary {
            if let str = id.valueForKeyPath("videoId") as? String {
                videoId = str
            }
        }
    }
}