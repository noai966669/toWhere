//
//  RecordViewController.h
//  Towhere
//
//  Created by apple on 15/7/17.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordViewController : UIViewController

-(IBAction)back:(id)sender;

@property (nonatomic , strong) IBOutlet UILabel *mailNo;         //快递单号。
@property (nonatomic , strong) IBOutlet UILabel *expTextName;    //快递名称。
@property (nonatomic , strong) IBOutlet UILabel *update;         //查询时间。
@property (nonatomic , strong) IBOutlet UILabel *danhao;         //单号。
           
-(IBAction)second:(id)sender;
@property (nonatomic , strong) IBOutlet UIButton *second;

@end
