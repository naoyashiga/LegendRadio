//
//  BaseTableViewController.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/07/01.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    var activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.viewBackgroundColor()
        tableView.separatorColor = UIColor.tableViewSeparatorColor()
        
        tableView.layoutMargins = UIEdgeInsetsZero
        
        setBackButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setNib(reuseIdentifier: String) {
        let userDetailsNIB = UINib(nibName: reuseIdentifier, bundle: nil)
        tableView.registerNib(userDetailsNIB, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func setBackButton() {
        let backButton = UIBarButtonItem(title: "< 戻る", style: UIBarButtonItemStyle.Plain, target: self, action: "goBack")
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AxisStd-Medium", size: 15)!], forState: UIControlState.Normal)
    }
    
    func goBack() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func showActivityIndicator(uiView: UIView) {
        activityIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        activityIndicator.center = uiView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.WhiteLarge
        uiView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func animateTable<T: UITableViewCell>(#customCell:T) {
        tableView.reloadData()
        
        let cells = tableView.visibleCells()
        let tableHeight: CGFloat = tableView.bounds.size.height
        let duration: NSTimeInterval = 0.5
        
        for i in cells {
            let cell = i as! UITableViewCell
            let storyCell = cell as! T
            //        storyCell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
            storyCell.transform = CGAffineTransformMakeTranslation(0, cell.frame.size.height / 3)
            storyCell.layer.opacity = 0
        }
        
        var index = 0
        
        for a in cells {
            let cell = a as! UITableViewCell
            let storyCell = cell as! T
            UIView.animateWithDuration(duration, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
                storyCell.transform = CGAffineTransformMakeTranslation(0, 0);
                storyCell.layer.opacity = 1.0
                }, completion: nil)
            
            index += 1
        }
    }
}
