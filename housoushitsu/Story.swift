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
        
        let snippet = data["snippet"] as! NSDictionary
        let id = data["id"] as! NSDictionary
        
        title = Utils.getStringFromJSON(snippet, key: "title")
        
        url = snippet.valueForKeyPath("thumbnails.default.url") as! String
        
        videoId = id.valueForKeyPath("videoId") as! String
    }
}