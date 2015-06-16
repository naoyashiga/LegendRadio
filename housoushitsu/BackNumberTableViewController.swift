//
//  BackNumberTableViewController.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/06/16.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class BackNumberTableViewController: UITableViewController {
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
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, tabBarHeight!, 0)
        

        var userDetailsNIB = UINib(nibName: reuseIdentifier, bundle: nil)
        self.tableView.registerNib(userDetailsNIB, forCellReuseIdentifier: reuseIdentifier)
        
        self.tableView.layoutMargins = UIEdgeInsetsZero
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
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
        
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
