//
//  DetailDeliveryTableViewCell.swift
//  Towhere
//
//  Created by ai966669 on 15/10/18.
//  Copyright © 2015年 elephant. All rights reserved.
//

import UIKit

class DetailDeliveryTableViewCell: UITableViewCell {

    @IBOutlet var location: UILabel!
    @IBOutlet var time: UILabel!
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
