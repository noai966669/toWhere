//
//  TopModel.swift
//  SuperGina
//
//  Created by apple on 15/7/23.
//  Copyright (c) 2015年 Anve. All rights reserved.
//

import UIKit

typealias SessionFailBlock = (code:Int) -> Void
typealias SessionSuccessBlock = (model : AnyObject?) -> Void

//code : -1.网络问题，未连接上服务器，-2 返回数据为空 -3code 返回为空 -4.提示Msg为nil -5.解析错误
let codeTokenUnvalible = -1014
let codeOverTime = 3840 //属于-1中的问题

class TopModel: NSObject {
    class func postParams(dic dic:Dictionary<String,AnyObject>,method:String,requsetingString:String?,successString:String?,
        failureString:String?,showNetActivity: Bool ,showServerfailureString:Bool,success:SessionSuccessBlock,failure:SessionFailBlock) -> Request {
            //风火轮转动
            if showNetActivity {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            }
            
            //判断时候有请求文字
            if requsetingString == "" {
                //SVProgressHUD.show()
            }else if requsetingString != nil{
                //SVProgressHUD.showWithStatus(requsetingString, maskType: .Clear)
            }

            //网络请求
            return request(Method.POST, "\(method)", parameters: dic, encoding:ParameterEncoding.URL).response { (request, response, data, error) -> Void in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                if response?.statusCode != 0 && response?.statusCode != 200{
                    if showServerfailureString {
                        //SVProgressHUD.showErrorWithStatus("网络异常")
                    }
                    print(response)
                    print(error)
                    if response?.statusCode == codeOverTime {
                        
                    }
                    failure(code: -1)
                }else{
                    guard let data = data  else {
                        print("无数据返回")
                        if error != nil{
                            if showServerfailureString {
                                //SVProgressHUD.showErrorWithStatus("网络异常")
                            }
                            
                        }
                        failure(code: -2)
                        return
                    }
                    
                    
                    do {
                        if	let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves) as? [String : AnyObject]{
                            print("\(json)")
                            guard let ret_code = json["code"] as? String else {
                                print("返回数据无code")
                                failure(code: -3)
                                return
                            }
                            if ret_code == "0001" {
                                if let successString = successString {
                                    //SVProgressHUD.showSuccessWithStatus(successString)
                                } else {
                                    //SVProgressHUD.dismiss()
                                }
                                success(model: json)
                            }else {
                                
                                guard let ret_msg = json["msg"] as? String else{
                                    //SVProgressHUD.showErrorWithStatus("请求失败...")
                                    if let ret_code_int = Int(ret_code){
                                        if ret_code_int == codeTokenUnvalible {
//                                            UserModel.printinOut(userId: "\(UserModel.sharedUserModel.id)")
                                        } else {
                                            failure(code: ret_code_int)
                                        }
                                        
                                    }else {
                                        failure(code: -4)
                                    }
                                    return
                                }
                                if showServerfailureString {
                                    if ret_msg != "" {
                                        //SVProgressHUD.showErrorWithStatus(ret_msg)
                                    } else if let failureString = failureString {
                                        //SVProgressHUD.showErrorWithStatus(failureString)
                                    } else {
                                        //SVProgressHUD.showErrorWithStatus("请求失败...")
                                    }
                                }
                                if let ret_code_int = Int(ret_code){
                                    failure(code: ret_code_int)
                                }else {
                                    failure(code: 0)
                                }
                            }
                            
                        }
                    }catch let error2 as NSError {
                        failure(code: -5)
                        print(error2.description)
                    }
                }
            }
    }
    /**
    网络请求公用接口
    
    :param: dic                     应用级别参数
    :param: method                  接口信息
    :param: requsetingString        请求显示Text，nil时不显示
    :param: successString           请求成功显示Text，nil时不显示
    :param: failureString           请求失败时，且ShowServerfailureString为false或者系统返回理由为空时显示Text，而此时为nil时则返回“请求失败”
    :param: showServerfailureString 是否返回服务器返回请求失败理由
    :param: success                 返回成功字典
    :param: failure                 返回失败
    */
    class func postParams(dic dic:Dictionary<String,AnyObject>,method:String,requsetingString:String?,successString:String?,
        failureString:String?,showServerfailureString:Bool,success:SessionSuccessBlock,failure:SessionFailBlock) -> Request{
            return postParams(dic: dic, method: method, requsetingString: requsetingString, successString: successString, failureString: failureString, showNetActivity: true, showServerfailureString: showServerfailureString, success: success, failure: failure)
            
    }
    
    class func getParams(dic dic:Dictionary<String,AnyObject>,subUrl:String,requsetingString:String?,successString:String?,
        failureString:String?,showServerfailureString:Bool,success:SessionSuccessBlock,failure:SessionFailBlock) -> Request{
            //风火轮转动
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            //判断时候有请求文字
            if requsetingString == "" {
                //SVProgressHUD.show()
            }else if requsetingString != nil{
                //SVProgressHUD.showWithStatus(requsetingString, maskType: .Clear)
            }
            
            //网络请求
            return request(Method.GET, "\(subUrl)", parameters: dic, encoding:ParameterEncoding.URL).response { (request, response, data, error) -> Void in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
                if response?.statusCode != 0 && response?.statusCode != 200{
                    if showServerfailureString {
                        //SVProgressHUD.showErrorWithStatus("网络异常")
                    }
                    failure(code: -1)
                }else{
                    guard let data = data  else {
//                        print("无数据返回")
                        if error != nil{
                            if showServerfailureString {
                                //SVProgressHUD.showErrorWithStatus("网络异常")
                            }
                            
                        }
                        failure(code: -2)
                        return
                    }
                    
                    
                    do {
                        if	let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves) as? [String : AnyObject]{
                            print("\(json)")
                            guard let ret_code = json["code"] as? String else {
                                print("返回数据无code")
                                failure(code: -3)
                                return
                            }
                            if ret_code == "0001" {
                                if let successString = successString {
                                    //SVProgressHUD.showSuccessWithStatus(successString)
                                } else {
                                    //SVProgressHUD.dismiss()
                                }
                                success(model: json)
                            }else {
                                
                                guard let ret_msg = json["msg"] as? String else{
                                    
                                    //SVProgressHUD.showErrorWithStatus("请求失败...")
                                    if let ret_code_int = Int(ret_code){
                                        if ret_code_int == codeTokenUnvalible {
//                                            UserModel.printinOut(userId: "\(UserModel.sharedUserModel.id)")
                                        } else {
                                            failure(code: ret_code_int)
                                        }
                                    }else {
                                        failure(code: -4)
                                    }
                                    return
                                }
                                if showServerfailureString {
                                    if ret_msg != "" {
                                        //SVProgressHUD.showErrorWithStatus(ret_msg)
                                    } else if let failureString = failureString {
                                        //SVProgressHUD.showErrorWithStatus(failureString)
                                    } else {
                                        //SVProgressHUD.showErrorWithStatus("请求失败...")
                                    }
                                }
                                if let ret_code_int = Int(ret_code){
                                    failure(code: ret_code_int)
                                }else {
                                    failure(code: 0)
                                }
                            }
                            
                        }
                    }catch let error2 as NSError {
                        failure(code: -5)
                        print(error2.description)
                    }
                    
                }
            }
            
    }

}
