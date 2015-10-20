//
//  MyselfViewController.h
//  Towhere
//
//  Created by apple on 15/7/15.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"

@interface MyselfViewController : UIViewController<ICSDrawerControllerChild, ICSDrawerControllerPresenting>

-(IBAction)back:(id)sender;
-(IBAction)myself:(id)sender;       //个人管理。
-(IBAction)addpost:(id)sender;      //收寄件人管理。
-(IBAction)advice:(id)sender;       //意见反馈。
-(IBAction)recommend:(id)sender;    //推荐给好友。
-(IBAction)about:(id)sender;        //关于我们。

@property(nonatomic, weak) ICSDrawerController *drawer;

@end
