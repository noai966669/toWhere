//
//  LoginViewController.h
//  Towhere
//
//  Created by apple on 15/7/15.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonCrypto.h>
#import "HttpClient.h"

@interface LoginViewController : UIViewController<DataLoadStateDelegate>{
    IBOutlet UITextField *phone;       //登录账号。
    IBOutlet UITextField *password;    //密码。
}

-(IBAction)back:(id)sender;

-(IBAction)password:(id)sender;       //忘记密码。
-(IBAction)login:(id)sender;          //登录到收快递页面。

@property (nonatomic ,retain) NSMutableArray *mutarrDataList;

@end
