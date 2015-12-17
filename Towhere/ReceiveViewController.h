//
//  ReceiveViewController.h
//  Towhere
//
//  Created by apple on 15/7/15.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpClient.h"
#import "ReceiveDetailViewController.h"
#import "ICSDrawerController.h"

@interface ReceiveViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate,UIAlertViewDelegate,DataLoadStateDelegate,ICSDrawerControllerChild, ICSDrawerControllerPresenting>{
    ReceiveDetailViewController *myReceiveDetailViewController;
}

-(IBAction)myself:(id)sender;     //个人中心。

//底部导航。
-(IBAction)query:(id)sender;      //查询。
-(IBAction)send:(id)sender;       //寄快递。

@property (nonatomic , strong) ReceiveDetailViewController *myReceiveDetailViewController;
@property (nonatomic , strong) IBOutlet UITableView *tableView1;
@property (nonatomic , retain) NSMutableArray *mutarrDataList;
//+(void)setIsCheckVersion:(BOOL)isCheckVersion;
//+(BOOL)getIsCheckVersion;
@property(nonatomic, strong) ICSDrawerController *drawer;
@end
    