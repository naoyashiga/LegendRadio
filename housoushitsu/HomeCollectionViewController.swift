//
//  HomeCollectionViewController.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/07/04.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class HomeCollectionViewController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    private var sections = [[Story]]()
//    private var sections = [[Story]]() {
//        didSet{
//            collectionView?.reloadData()
//        }
//    }
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
        
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height
        collectionView?.contentInset = UIEdgeInsetsMake(10, cellHorizontalMargin / 2, tabBarHeight!, cellHorizontalMargin / 2)
        
        
        collectionView?.backgroundColor = UIColor.viewBackgroundColor()
        
        setStories()
        
        collectionView?.registerNib(UINib(nibName: reuseIdentifier_homeHeaderView, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseIdentifier_homeHeaderView)
        
        collectionView?.registerNib(UINib(nibName: reuseIdentifier_viewoListCell, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier_viewoListCell)
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
                self.collectionView?.reloadData()
                println(self.sections.count)
                self.activityIndicator.stopAnimating()
            }
        })
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return sectionCount
    }
    

    var headerIndex = 0
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: reuseIdentifier_homeHeaderView, forIndexPath: indexPath) as! HomeHeaderView
            
            if queries.count == sectionCount {
                headerView.headerTitleLabel.text = queries[indexPath.section]
            }
            
            let cornerRadius: CGFloat = 5.0
            let maskPath = UIBezierPath(roundedRect: headerView.bounds, byRoundingCorners: (UIRectCorner.TopLeft | UIRectCorner.TopRight), cornerRadii: CGSizeMake(cornerRadius, cornerRadius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = headerView.bounds
            maskLayer.path = maskPath.CGPath
            headerView.layer.mask = maskLayer
            
            return headerView
            
        default:
            assert(false, "error")
        }
    }
    

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return sectionStoriesCount
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier_viewoListCell, forIndexPath: indexPath) as! VideoListCollectionViewCell
    
//        println(sections.count)
        
        if sections.count == 0 {
            return cell
        }
        
        let sectionStories = sections[indexPath.section]
        let story = sectionStories[indexPath.row]
        
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
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier_viewoListCell, forIndexPath: indexPath) as! VideoListCollectionViewCell
        
        let sectionStories = sections[indexPath.section]
        let story = sectionStories[indexPath.row]
        
        let vc = DetailViewController(nibName: "DetailViewController", bundle: nil)
        vc.videoId = story.videoId
        vc.navigationItem.title = story.title
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: cellWidth, height: 45)
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
        return UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }
}
