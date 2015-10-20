//
//  ChangePasswordViewController.h
//  Towhere
//
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpClient.h"

@interface ChangePasswordViewController : UIViewController<DataLoadStateDelegate>{
    IBOutlet UITextField *oldPassword;    //原密码。
    IBOutlet UITextField *password;       //新密码。
}

-(IBAction)back:(id)sender;
-(IBAction)finish:(id)sender;    //确认。

@end
