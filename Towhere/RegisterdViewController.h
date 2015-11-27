//
//  RegisterdViewController.h
//  Towhere
//
//  Created by apple on 15/7/15.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "University.h"
#import "HttpClient.h"

@interface RegisterdViewController : UIViewController<DataLoadStateDelegate>{
    IBOutlet UITextField *name;                //姓名。
    IBOutlet UITextField *iphone;              //手机。
    IBOutlet UITextField *universityName;      //大学名称。
    IBOutlet UITextField *password;            //密码。
    IBOutlet UITextField *verification;        //验证码。
}

-(IBAction)back:(id)sender;
-(IBAction)huoqu:(id)sender;            //获取验证码。
-(IBAction)registerd:(id)sender;        //注册。
-(IBAction)agreement:(id)sender;        //协议。

-(IBAction)close:(id)sender;            //关闭键盘。

@property (nonatomic , strong) University *university;

@end