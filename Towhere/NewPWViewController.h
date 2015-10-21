//
//  NewPWViewController.h
//  Towhere
//
//  Created by apple on 15/9/10.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpClient.h"

@interface NewPWViewController : UIViewController<DataLoadStateDelegate>{
    IBOutlet UITextField *password;   //密码。
    IBOutlet UITextField *againPW;    //再次输入密码。
}

-(IBAction)back:(id)sender;
-(IBAction)tijiao:(id)sender;

@end
