//
//  DatabaseDelivery.swift
//  Towhere
//
//  Created by ai966669 on 15/10/17.
//  Copyright © 2015年 elephant. All rights reserved.
//

import UIKit
func getNameByCode(code:String)->String{
    switch (code) {
    case "ems":
        return "EMS快递"
    case "huitong":
        return "汇通快递"
    case "shentong":
        return "申通快递"
    case "shunfeng":
        return "顺丰快递"
    case "tiantian":
        return "天天快递"
    case "yuantong":
        return "圆通快递"
    case "yunda":
        return "韵达快递"
    case "zhongtong":
        return "中通快递"
    default:
        return "EMS快递"
        
    }
}

class DatabaseDelivery: NSObject {
    
    
    
    static var KEY_USERNAME = "com.company.app.username"
    static var KEY_PASSWORD = "com.company.app.password"
    
    class func createDataBasedeliveryHistroy()->Int32{
        let con1 = databaseGet()
        let sql1 = "CREATE TABLE if not exists deliveryHistroy (number Text,userId Text,time Text,code Text,PRIMARY KEY(userId,number))"
        let binddata1=NSMutableArray()
        let types1=[]
        return con1.getR3(sql1, binddata1, types1 as [AnyObject])
    }
    class func deleteDeliveryHistroyByUseridAndNumber(userId:String,number:String)->Int32{
        let con1 = databaseGet()
        let sql1 = "delete from  deliveryHistroy where userid=? and number=?"
        let binddata1=NSMutableArray()
        binddata1.addObject("\(userId)")
        binddata1.addObject("\(number)")
        let types1=[ NSNumber(int: 1),NSNumber(int: 1)]
        return con1.getR3(sql1, binddata1, types1)
    }
    class func getDeliveryHistroy()->[MDeliveryHistory]{
        let con1 = databaseGet()
        let sql1 = "select * from deliveryHistroy where userId = ? limit 10"
        let binddata1=NSMutableArray()
        let userName=MyKeyChainHelper.getPasswordWithService(KEY_USERNAME)
        let types1=[ NSNumber(int: 1),NSNumber(int: 1),NSNumber(int: 1),NSNumber(int: 1)]
        binddata1.addObject("\(userName)")
        let r1InNSMutableArray=con1.getR2(sql1, binddata1, types1)
        if r1InNSMutableArray.count>0{
            var arrMDeliveryHistory:[MDeliveryHistory]=[]
            if r1InNSMutableArray.count>0{
                for i in 0...r1InNSMutableArray.count/4-1{
                    arrMDeliveryHistory.append(MDeliveryHistory().initMDeliveryHistory(r1InNSMutableArray[4*i+0] as! String, aTime: r1InNSMutableArray[4*i+2] as! String, aCode: r1InNSMutableArray[4*i+3] as! String))
                }
            }
            return arrMDeliveryHistory
        }else{
            return []
        }
    }
    class func saveDeliveryHistroy(arrMDeliveryHistory:[MDeliveryHistory]){
        let con1 = databaseGet()
        //        number Text PRIMARY KEY,userId Text,time Text,code Text
        for aDeliveryHistory in arrMDeliveryHistory{
            let sql1 = "insert into deliveryHistroy values(?,?,?,?)"
            let binddata1=NSMutableArray()
            binddata1.addObject("\(aDeliveryHistory.number)")
            binddata1.addObject("\(aDeliveryHistory.userId)")
            binddata1.addObject("\(aDeliveryHistory.time)")
            binddata1.addObject("\(aDeliveryHistory.code)")
            let types1=[ NSNumber(int: 1),NSNumber(int: 1),NSNumber(int: 1),NSNumber(int: 1)]
            con1.getR3(sql1, binddata1, types1)
        }
    }
}
