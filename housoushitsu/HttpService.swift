//
//  HttpService.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/06/08.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import Foundation
import UIKit

class HttpService {
    class func getJSON(url: String, callback:((NSArray) -> Void)) {
//        var nsURL = NSURL(string: url)!
        
        if let nsURL = NSURL(string: url) {
            var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithURL(nsURL, completionHandler: { data, response, error -> Void in
            
            if error != nil{
                println("error")
            }
            
            if data != nil {
                let jsonData = NSJSONSerialization.JSONObjectWithData( data, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
                let arry = jsonData.objectForKey("items") as! NSArray
                callback(arry)
            }
            
            session.invalidateAndCancel()
            
        })
        task.resume()
            
        }
    }
}