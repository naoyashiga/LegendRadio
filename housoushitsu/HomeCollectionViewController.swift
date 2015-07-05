//
//  HomeCollectionViewController.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/07/04.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class HomeCollectionViewController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    private var sections = [[Story]]() {
        didSet{
            collectionView?.reloadData()
        }
    }
    private var queries = [String]()
    private let sectionStoriesCount = 3
    private let sectionCount = 8
    
    let reuseIdentifier_viewoListCell = "VideoListCollectionViewCell"
    let reuseIdentifier_homeHeaderView = "HomeHeaderView"
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
        
        collectionView?.registerNib(UINib(nibName: reuseIdentifier_homeHeaderView, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseIdentifier_homeHeaderView)
        
        collectionView?.registerNib(UINib(nibName: reuseIdentifier_viewoListCell, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier_viewoListCell)
        
        setStories()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
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

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return sectionCount
    }

    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: reuseIdentifier_homeHeaderView, forIndexPath: indexPath) as! HomeHeaderView
            
//            headerView.backgroundColor = UIColor.redColor()
            
            return headerView
            
        default:
            assert(false, "error")
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
//        return CGSize(width: cellWidth - cellHorizontalMargin, height: cellHeight / 3)
        return CGSize(width: 100, height: 50)
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 3
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier_viewoListCell, forIndexPath: indexPath) as! VideoListCollectionViewCell
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier_viewoListCell, forIndexPath: indexPath) as! VideoListCollectionViewCell
    }
    
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
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
