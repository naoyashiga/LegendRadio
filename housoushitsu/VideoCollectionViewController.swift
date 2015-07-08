//
//  VideoCollectionViewController.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/07/07.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class VideoCollectionViewController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    private var stories:[Story] = [Story]() {
        didSet{
            self.collectionView?.reloadData()
        }
    }
    
    private let storiesCount = 10
    
    let reuseIdentifier_viewoListCell = "VideoListCollectionViewCell"
    var searchText = ""
    var index = 0
    
    private var cellWidth:CGFloat = 0.0
    private var cellHeight:CGFloat = 0.0
    
    private let cellVerticalMargin:CGFloat = 2.0
    private let cellHorizontalMargin:CGFloat = 20.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellWidth = view.bounds.width
        cellHeight = view.bounds.height / 8
        
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height
        
//        collectionView?.contentInset = UIEdgeInsetsMake(10, cellHorizontalMargin / 2, tabBarHeight!, cellHorizontalMargin / 2)
//        
//        
//        collectionView?.backgroundColor = UIColor.viewBackgroundColor()
        
        setStories()
        
        collectionView?.registerNib(UINib(nibName: reuseIdentifier_viewoListCell, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier_viewoListCell)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
//            self.activityIndicator.stopAnimating()
        })
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return storiesCount
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier_viewoListCell, forIndexPath: indexPath) as! VideoListCollectionViewCell
        
        if stories.count == 0 {
            return cell
        }
        
        let story = stories[indexPath.row]
        
        cell.titleLabel.text = story.title
        cell.thumbNailImageView.sd_setImageWithURL(NSURL(string: story.url))
        
        VideoInfo.getDurationTimes(story.videoId, callback: { (contentDetails) -> Void in
//            let duration = contentDetails[0].duration
//            cell.durationLabel.text = VideoInfo.getDurationStr(duration)
        })
        
        VideoInfo.getStatistics(story.videoId, callback: { (statistics) -> Void in
//            cell.viewCountLabel.text = statistics[0].viewCount
//            cell.likeCountLabel.text = statistics[0].likeCount
        })
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier_viewoListCell, forIndexPath: indexPath) as! VideoListCollectionViewCell
        
        let story = stories[indexPath.row]
        
        let vc = DetailViewController(nibName: "DetailViewController", bundle: nil)
        vc.videoId = story.videoId
        vc.navigationItem.title = story.title
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: cellWidth - cellHorizontalMargin, height: cellHeight)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellVerticalMargin
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "VideoList" {
//            let vc = segue.destinationViewController as! VideoCollectionViewController
//            vc.searchText = "放送室 101"
//        }
//    }
}
