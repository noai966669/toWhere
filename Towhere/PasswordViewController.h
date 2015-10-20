//
//  PasswordViewController.h
//  Towhere
//
//  Created by apple on 15/7/15.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpClient.h"

@interface PasswordViewController : UIViewController<DataLoadStateDelegate>{
    IBOutlet UITextField *phone;        //电话
    IBOutlet UITextField *yanzhengma;   //验证码。
}

-(IBAction)back:(id)sender;
-(IBAction)yzm:(id)sender;     //验证码。
-(IBAction)tijiao:(id)sender;  //提交。

@end
