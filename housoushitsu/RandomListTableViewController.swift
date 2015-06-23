//
//  RandomListTableViewController.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/06/23.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class RandomListTableViewController: ListTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func setSearchText() -> String {
        return "放送室 100"
    }
    
    override func setStories() {
        let searchWord = setSearchText()
        let requestURL = Config.REQUEST_BASE_URL + "q=\(searchWord)&part=snippet&maxResults=10&order=viewCount"
        
        println(requestURL)
        
        
        HousoushitsuObjectHandler.getStories(requestURL, callback: {(stories) -> Void in
            self.stories = stories
            println(self.stories)
        })
    }
}
