//
//  Config.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/06/08.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import Foundation

struct Config {
    static let API_KEY = "AIzaSyDItoguSdvqahLRClFdP2VkixPaJcfd_I4"
    static let REQUEST_BASE_URL = "https://www.googleapis.com/youtube/v3/"
    static let REQUEST_SEARCH_URL = REQUEST_BASE_URL + "search?key=\(API_KEY)&"
    static let REQUEST_CONTENT_DETAILS_URL = REQUEST_BASE_URL + "videos?key=\(API_KEY)&part=contentDetails&"
    static let REQUEST_STATISTICS_URL = REQUEST_BASE_URL + "videos?key=\(API_KEY)&part=statistics&"
    
}