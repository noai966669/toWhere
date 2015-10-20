//
//  D3json.swift
//  D3Json
//
//  Created by mozhenhau on 15/2/12.
//  Copyright (c) 2015年 mozhenhau. All rights reserved.
//

import Foundation

public class D3Json{
    class func jsonToModel<T>(dics:AnyObject?,clazz:AnyClass)->T!{
        if dics == nil{
            return nil
        }

        var properties: Mirror!
        var obj: AnyObject!
        guard let nSClass = clazz as? NSObject.Type else {
            print("该类父类非NSObject")
            return nil
        }
        
        obj = nSClass.init()
        
        properties = Mirror(reflecting: obj)

        
        var dic:AnyObject!
        if dics is NSArray{
            dic = dics!.lastObject
        }
        else{
            dic = dics
        }
        
        
        if dic != nil{
            if let b = AnyBidirectionalCollection(properties.children) {
                for i in b.endIndex.advancedBy(-40, limit: b.startIndex)..<b.endIndex {
                    
                    let key = b[i].label!
                    let value = b[i].value
//                    print("Keys:\(key)")
                    guard let valueDic = dic.objectForKey(key) else{
                        print("key:\(key) not have value")
                        continue
                    }
                    
                    switch value {
                    case is Int,is Double,is Int32,is Int64,is Bool,is Float:
                        print("key:\(key) values:\(valueDic)")
                        
                        if !(valueDic is NSNull){
                            obj.setValue(valueDic, forKey: key)
                        }

                        
                        
                    case is String:
                        if (valueDic is NSNull){
                            obj.setValue("", forKey: key)
                        }else {
                            obj.setValue(valueDic.description, forKey: key)
                        }

                    case is Array<String>:
                        if let nsarray = dic?.objectForKey(key) as? NSArray {
                            var array:Array<String> = []
                            for el in nsarray {
                                if let typedElement = el as? String {
                                    array.append(typedElement)
                                }
                            }
                            obj.setValue(array, forKey: key)
                        }
                    case is Array<Int>:
                        if let nsarray = dic?.objectForKey(key) as? NSArray {
                            var array:Array<Int> = []
                            for el in nsarray {
                                if let typedElement = el as? Int {
                                    array.append(typedElement)
                                }
                            }
                            obj.setValue(array, forKey: key)
                        }
                        
                    default:
                        addExtension(key,value:value,obj:obj,dic:dic)
                    }
                }
            }
          
        }
        else{
            return nil
        }
        return (obj as! T)
    }
    
    //MARK: json转到model list,传入anyobject
    public class func jsonToModelList<T>(data:AnyObject?,clazz:AnyClass)->Array<T>{
        if data == nil{
            return []
        }
        
        var objs:Array<T> = []
        if let dics = data as? NSArray{
            for(var i = 0 ;i < dics.count;i++){
                let dic:AnyObject = dics[i]
                
                objs.append(jsonToModel(dic,clazz: clazz))
            }
        }
        return objs
    }
    
    
    /**
    上面只实现了基本类型的，如果是自己定义的model，在此处做扩展.此处作例子，不需要可清除。
    如有自己的User类，则增加：
    case _ as User.Type:
    obj.setValue(jsonToModel(dic.objectForKey(key), clazz: User.self, objc: User()),forKey:key)
    如有自己的Job类，则把User改成Job则可
    
    :param: key  属性名
    :param: type 属性的类型
    :param: obj  要赋值的对象
    :param: dic  json对象
    */
    private class func addExtension(key:String,value:Any,obj:AnyObject,dic:AnyObject){
        switch value {
//        case is [MCategory]:
//                let value: AnyObject? = dic.objectForKey(key)
//                if value != nil{
//                let arr : [MCategory] = jsonToModelList(value, clazz: MCategory.self)
//                obj.setValue(arr, forKey: key)
//                }
//        case is [ThirdInfo]:
//            let value: AnyObject? = dic.objectForKey(key)
//            if value != nil{
//                let arr : [ThirdInfo] = jsonToModelList(value, clazz: ThirdInfo.self)
//                print("\(arr.count)")
//                obj.setValue(arr, forKey: key)
//            }
//        case is [Support]:
//            let value: AnyObject? = dic.objectForKey(key)
//            if value != nil{
//                let arr : [Support] = jsonToModelList(value, clazz: Support.self)
//                print("\(arr.count)")
//                obj.setValue(arr, forKey: key)
//            }
//        case is [Unit]:
//            let value: AnyObject? = dic.objectForKey(key)
//            if value != nil{
//                let arr : [Unit] = jsonToModelList(value, clazz: Unit.self)
//                print("\(arr.count)")
//                obj.setValue(arr, forKey: key)
//            }
//        case is [itemInOrderDetail]:
//            let value: AnyObject? = dic.objectForKey(key)
//            if value != nil{
//                let arr : [itemInOrderDetail] = jsonToModelList(value, clazz: itemInOrderDetail.self)
//                print("\(arr.count)")
//                obj.setValue(arr, forKey: key)
//            }
//
//        case is OrderInfo:
//            let value: AnyObject? = dic.objectForKey(key)
//            if value != nil{
//                let oneOrderInfo : OrderInfo = jsonToModel(value,clazz: OrderInfo.self)
//                obj.setValue(oneOrderInfo, forKey: key)
//            }
//        case is [Mmsg]:
//            let value: AnyObject? = dic.objectForKey(key)
//            if value != nil{
//                let arr : [Mmsg] = jsonToModelList(value, clazz: Mmsg.self)
//                print("\(arr.count)")
//                obj.setValue(arr, forKey: key)
//            }
            
//
//        case _ as Job.Type:
//            obj.setValue(jsonToModel(dic.objectForKey(key), objc: Job()),forKey:key)
            
        default:     //unknow
            print("key:\(key),unknow,sure that you hava init")
        }
    }
    
}