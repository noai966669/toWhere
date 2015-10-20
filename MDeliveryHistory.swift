//
//  MDeliveryHistory.swift
//  Towhere
//
//  Created by ai966669 on 15/10/17.
//  Copyright © 2015年 elephant. All rights reserved.
//

import UIKit
//number Text,userId Text,time Text,code Text,deliveryId TEXT PRIMARY KEY
class MDeliveryHistory: NSObject {
    var number=""
    var userId = ""
    var time = ""
    var code = ""
//    number Text PRIMARY KEY,userId Text,time Text,code Text
    func initMDeliveryHistory(aNumber:String,aTime:String,aCode:String)->MDeliveryHistory{
        number=aNumber
        userId=MyKeyChainHelper.getUserNameWithService("com.company.app.username")
        time=aTime
        code=aCode
        return self
    }
}
