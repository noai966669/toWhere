//
//  DeliveryHistoryListTableViewCell.swift
//  Towhere
//
//  Created by ai966669 on 15/10/17.
//  Copyright © 2015年 elephant. All rights reserved.
//

import UIKit

class DeliveryHistoryListTableViewCell: UITableViewCell {
    @IBOutlet var img: UIImageView!
    @IBOutlet var time: UILabel!
    @IBOutlet var detail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
