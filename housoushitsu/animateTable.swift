//
//  animateTable.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/07/01.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit
func animateTable<T: UITableViewCell>(#customCell:T,tableView:UITableView) {
    tableView.reloadData()
    
    let cells = tableView.visibleCells()
    let tableHeight: CGFloat = tableView.bounds.size.height
    
    for i in cells {
        let cell = i as! UITableViewCell
        let storyCell = cell as! T
        storyCell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
    }
    
    var index = 0
    
    for a in cells {
        let cell = a as! UITableViewCell
        let storyCell = cell as! T
        UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            storyCell.transform = CGAffineTransformMakeTranslation(0, 0);
            }, completion: nil)
        
        index += 1
    }
}