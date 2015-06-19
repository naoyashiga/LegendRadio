//
//  SecondBackNumberTableViewController.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/06/19.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class SecondBackNumberTableViewController: UITableViewController {
    private let reuseIdentifier = "BackNumberTableViewCell"
    
    var initialIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var userDetailsNIB = UINib(nibName: reuseIdentifier, bundle: nil)
        self.tableView.registerNib(userDetailsNIB, forCellReuseIdentifier: reuseIdentifier)
        
        self.tableView.layoutMargins = UIEdgeInsetsZero
        
        self.navigationItem.title = "第\(initialIndex)回-第\(initialIndex + 10)回"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sections[section]
//    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! BackNumberTableViewCell
        
        let start = initialIndex + indexPath.row
        
        cell.backNumberLabel.text = "第\(start)回"
        
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! BackNumberTableViewCell
        let start = cell.backNumberLabel.text
        println(start)
    }
}
