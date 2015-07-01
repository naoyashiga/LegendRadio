//
//  BackNumberTableViewController.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/06/16.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class BackNumberTableViewController: BaseTableViewController {
    private let reuseIdentifier = "BackNumberTableViewCell"
    
    private let sections = [
        "第1~50回",
        "第51~100回",
        "第101~150回",
        "第151~200回",
        "第201~250回",
        "第251~300回",
        "第301~350回",
        "第351~397回",
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarHeight = tabBarController?.tabBar.frame.size.height
        
        tableView.contentInset = UIEdgeInsetsMake(0, 0, tabBarHeight!, 0)

        var userDetailsNIB = UINib(nibName: reuseIdentifier, bundle: nil)
        tableView.registerNib(userDetailsNIB, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.estimatedRowHeight = view.frame.height / 20
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        animateTable(customCell: BackNumberTableViewCell())
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        
        header.textLabel.font = UIFont(name: "AxisStd-Bold", size: 20)
        header.contentView.backgroundColor = UIColor.tableHeaderBackgroundColor()
        header.textLabel.textColor = UIColor.tableHeaderTextColor()
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! BackNumberTableViewCell
        
        let start = indexPath.section * 50 + indexPath.row * 10 + 1
        var end = 0
        
        if start == 391 {
            end = 397
        }else{
            end = start + 9
        }

        cell.backNumberLabel.text = "第\(start)回-第\(end)回"
        
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
        let start = indexPath.section * 50 + indexPath.row * 10 + 1
        println(start)
        
        
        let vc = SecondBackNumberTableViewController()
        vc.initialIndex = start
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
