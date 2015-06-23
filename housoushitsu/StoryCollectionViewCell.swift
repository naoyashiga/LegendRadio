//
//  StoryCollectionViewCell.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/06/23.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var backNumberLabel: UILabel!
    @IBOutlet weak var thumbNailImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
