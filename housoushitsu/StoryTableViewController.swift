//
//  StoryTableViewController.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/06/30.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class StoryTableViewController: BaseTableViewController {
    private var sections = [[Story]]() {
        didSet{
            self.tableView?.reloadData()
        }
    }
    private var queries = [String]()
    private let sectionStoriesCount = 3
    private let sectionCount = 8
    
    let reuseIdentifier = "ListTableViewCell"
    var searchText = ""
    var index = 0
    
//    var contentDetails = [ContentDetails]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStories()
        setNib(reuseIdentifier)
        
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height
        tableView.contentInset = UIEdgeInsetsMake(0, 0, tabBarHeight!, 0)
        
//        tableView.estimatedRowHeight = 200
//        tableView.rowHeight = UITableViewAutomaticDimension
        
        showActivityIndicator(view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        animateTable(customCell: ListTableViewCell())
    }
    
    
    // MARK: - Table view data source
    func setSearchText() -> String {
        let storyIndex = arc4random() % 391 + 1
        var searchText = ""
        
        if storyIndex < 10 {
            searchText = "放送室 00\(storyIndex)"
        } else if (storyIndex < 100) {
            searchText = "放送室 0\(storyIndex)"
        } else {
            searchText = "放送室 \(storyIndex)"
        }
        
        queries.append("第\(storyIndex)回")
        
        let text = searchText.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        return text!
    }
    
    func setStories() {
        let searchWord = setSearchText()
        let requestURL = Config.REQUEST_SEARCH_URL + "q=\(searchWord)&part=snippet&maxResults=\(sectionStoriesCount)"
        
        HousoushitsuObjectHandler.getStories(requestURL, callback: {(stories) -> Void in
            self.index++
            self.sections.append(stories)
            
            if self.index < self.sectionCount {
                self.setStories()
            } else {
//                println("finish")
                self.activityIndicator.stopAnimating()
            }
        })
    }
    
    func getDurationTimes(videoID: String, callback:(([ContentDetails]) -> Void)) {
        let contentsDetailURL = Config.REQUEST_CONTENT_DETAILS_URL + "id=\(videoID)"
        
        HousoushitsuObjectHandler.getContentDetails(contentsDetailURL, callback: {(contentDetails) -> Void in
            callback(contentDetails)
        })
    }
    
    func getStatistics(videoID: String, callback:(([Statistics]) -> Void)) {
        let statisticsURL = Config.REQUEST_STATISTICS_URL + "id=\(videoID)"
        
        HousoushitsuObjectHandler.getStatistics(statisticsURL, callback: {(statistics) -> Void in
            callback(statistics)
        })
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return queries[section]
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        
        header.textLabel.font = UIFont(name: "AxisStd-Bold", size: 20)
        header.contentView.backgroundColor = UIColor.tableHeaderBackgroundColor()
        header.textLabel.textColor = UIColor.tableHeaderTextColor()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.frame.height / 6
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionStoriesCount
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ListTableViewCell
        
        let sectionStories = sections[indexPath.section]
        let story = sectionStories[indexPath.row]
        
        cell.titleLabel.text = story.title
        cell.thumbNailImageView.sd_setImageWithURL(NSURL(string: story.url))
        
        getDurationTimes(story.videoId, callback: { (contentDetails) -> Void in
            //PT2H10M11S
            let duration = contentDetails[0].duration
            cell.durationLabel.text = self.getDurationStr(duration)
        })
        
        getStatistics(story.videoId, callback: { (statistics) -> Void in
//            let viewCount = statistics[0].viewCount
//            let likeCount = statistics[0].likeCount
            cell.viewCountLabel.text = statistics[0].viewCount
            cell.likeCountLabel.text = statistics[0].likeCount
        })
        
        cell.layoutIfNeeded()
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.cellLightBackgroundColor()
        } else {
            cell.backgroundColor = UIColor.cellDarkBackgroundColor()
        }
        
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ListTableViewCell
        
        let sectionStories = sections[indexPath.section]
        let story = sectionStories[indexPath.row]
        
        let vc = DetailViewController(nibName: "DetailViewController", bundle: nil)
        vc.videoId = story.videoId
        vc.navigationItem.title = story.title
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func getDurationStr(nonFormatStr: String) -> String {
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
    
    func doReplace(#str:String, pattern: String, replaceStr: String) -> String {
        return str.stringByReplacingOccurrencesOfString(pattern, withString: replaceStr, options: NSStringCompareOptions.RegularExpressionSearch, range: nil)
        
    }
}
