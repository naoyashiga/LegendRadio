//
//  SecondBackNumberTableViewController.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/06/19.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class SecondBackNumberTableViewController: BaseTableViewController {
    private let reuseIdentifier = "BackNumberTableViewCell"
    
    var initialIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNib(reuseIdentifier)
        
//        tableView.estimatedRowHeight = 150
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        animateTable(customCell: BackNumberTableViewCell())
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sections[section]
//    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.frame.height / 8
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! BackNumberTableViewCell
        
        let start = initialIndex + indexPath.row
        
        cell.backNumberLabel.text = "第\(start)回"
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.cellLightBackgroundColor()
        } else {
            cell.backgroundColor = UIColor.cellDarkBackgroundColor()
        }
        
        cell.layoutIfNeeded()
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! BackNumberTableViewCell
        let start = cell.backNumberLabel.text
        println(start)
        
        let vc = ListTableViewController()
        
        var storyIndex = initialIndex + indexPath.row
        var storyIndexStr = ""
        
        if storyIndex < 100 {
            storyIndexStr = "0" + String(initialIndex + indexPath.row)
            vc.searchText = "放送室 \(storyIndexStr)"
        } else {
            vc.searchText = "放送室 \(storyIndex)"
        }
        
        vc.navigationItem.title = "第\(storyIndex)回の検索結果"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
