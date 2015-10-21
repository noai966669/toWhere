//
//  AlreadyTwoViewController.h
//  Towhere
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlreadySend.h"

@interface AlreadyTwoViewController : UIViewController

-(IBAction)back:(id)sender;

@property (nonatomic , strong) AlreadySend *alreadySend;

@property (nonatomic , weak) IBOutlet UILabel *kdnumber;      //快递单号。
@property (nonatomic , weak) IBOutlet UILabel *daname;        //收件人。
@property (nonatomic , weak) IBOutlet UILabel *daaddress;     //收件人地址。
@property (nonatomic , weak) IBOutlet UILabel *paname;        //寄件人。
@property (nonatomic , weak) IBOutlet UILabel *paphone;       //寄件人电话。
@property (nonatomic , weak) IBOutlet UILabel *weight;        //重量。
@property (nonatomic , weak) IBOutlet UILabel *companyname;  //快递公司。
@property (nonatomic , weak) IBOutlet UILabel *price;         //价格。

@end
