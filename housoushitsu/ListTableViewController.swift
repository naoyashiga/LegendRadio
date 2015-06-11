//
//  ListTableViewController.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/06/08.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    private var stories:[Story] = [Story]() {
        didSet{
            self.tableView?.reloadData()
        }
    }
    
    let reuseIdentifier = "ListTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchText = "放送室 270"
        let searchWord:String! = searchText.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let requestURL = Config.REQUEST_BASE_URL + "q=\(searchWord)&part=snippet&maxResults=10&order=viewCount"
        
        var userDetailsNIB = UINib(nibName: reuseIdentifier, bundle: nil)
        self.tableView.registerNib(userDetailsNIB, forCellReuseIdentifier: reuseIdentifier)

//        self.tableView.registerClass(ListTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        HousoushitsuObjectHandler.getStories(requestURL, callback: {(stories) -> Void in
            self.stories = stories
            println(self.stories)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ListTableViewCell
        
        let story = stories[indexPath.row]
        
        println(story.title)
        cell.titleLabel.text = story.title
        


        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ListTableViewCell
        
        let story = stories[indexPath.row]
        
        let vc = DetailViewController(nibName: "DetailViewController", bundle: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
