//
//  ListTableViewController.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/06/08.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class ListTableViewController: BaseTableViewController {
    private var stories:[Story] = [Story]() {
        didSet{
            self.tableView?.reloadData()
        }
    }
    
    private let storiesCount = 6
    let reuseIdentifier = "ListTableViewCell"
    var searchText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStories()
        setNib(reuseIdentifier)
        showActivityIndicator(view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        animateTable(customCell: ListTableViewCell())
    }
    
    func setSearchText() -> String {
        let text = searchText.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        return text!
    }
    
    func setStories() {
        let searchWord = setSearchText()
        let requestURL = Config.REQUEST_SEARCH_URL + "q=\(searchWord)&part=snippet&maxResults=\(storiesCount)"
        
        HousoushitsuObjectHandler.getStories(requestURL, callback: {(stories) -> Void in
            self.stories = stories
//            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        })
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.frame.height / 6
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storiesCount
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ListTableViewCell
        
        let story = stories[indexPath.row]
        
        cell.titleLabel.text = story.title
        cell.thumbNailImageView.sd_setImageWithURL(NSURL(string: story.url))
        
        VideoInfo.getDurationTimes(story.videoId, callback: { (contentDetails) -> Void in
            let duration = contentDetails[0].duration
            cell.durationLabel.text = VideoInfo.getDurationStr(duration)
        })
        
        VideoInfo.getStatistics(story.videoId, callback: { (statistics) -> Void in
            cell.viewCountLabel.text = statistics[0].viewCount
            cell.likeCountLabel.text = statistics[0].likeCount
        })
        
        
        cell.layoutIfNeeded()
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ListTableViewCell
        let story = stories[indexPath.row]
        let vc = DetailViewController(nibName: "DetailViewController", bundle: nil)
        
        vc.videoId = story.videoId
        vc.videoTitle = story.title
        
        vc.navigationItem.title = story.title
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
