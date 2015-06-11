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
    
    override init(data: NSDictionary) {
        super.init(data: data)
        
        let snippet = data["snippet"] as! NSDictionary
        self.title = Utils.getStringFromJSON(snippet, key: "title")
        println(self.title)
        
        
//        let images = data["images"] as! NSDictionary
//        self.imageUrl = Utils.getStringFromJSON(images, key: "normal")
//        self.htmlUrl = data["html_url"] as! String
//        
//        shotName = data["title"] as! String
//        let user = data["user"] as! NSDictionary
//        designerName = Utils.getStringFromJSON(user, key: "name")
//        avatarUrl = Utils.getStringFromJSON(user, key: "avatar_url")
//        shotCount = data["views_count"] as! Int
    }
}