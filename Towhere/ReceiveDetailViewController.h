//
//  ReceiveDetailViewController.h
//  Towhere
//
//  Created by apple on 15/7/22.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Receive.h"

@interface ReceiveDetailViewController : UIViewController

@property (nonatomic , strong) IBOutlet UILabel *detailLabel;      //详情。
@property (nonatomic , strong) IBOutlet UILabel *timeLabel;        //时间。

-(IBAction)back:(id)sender;

//底部导航。
-(IBAction)query:(id)sender;      //查询。
-(IBAction)send:(id)sender;       //寄快递。

@property (nonatomic , strong) Receive *receive;

@end
