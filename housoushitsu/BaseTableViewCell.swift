//
//  BaseTableViewCell.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/07/02.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        let cellSelectedBgView = UIView()
        cellSelectedBgView.backgroundColor = UIColor.clearColor()
        selectedBackgroundView = cellSelectedBgView
    }

}
