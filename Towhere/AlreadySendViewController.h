//
//  AlreadySendViewController.h
//  Towhere
//
//  Created by apple on 15/8/10.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpClient.h"
#import "AlreadyTwoViewController.h"
#import "ICSDrawerController.h"

@interface AlreadySendViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate,UIAlertViewDelegate,DataLoadStateDelegate,ICSDrawerControllerChild, ICSDrawerControllerPresenting>{
    AlreadyTwoViewController *myAlreadyTwoViewController;
}

-(IBAction)myself:(id)sender;      //个人中心。
-(IBAction)waitsend:(id)sender;    //待寄。
-(IBAction)wantsend:(id)sender;    //我要寄快递。
-(IBAction)query:(id)sender;       //查询。

@property (nonatomic , strong) AlreadyTwoViewController *myAlreadyTwoViewController;
@property (nonatomic , strong) IBOutlet UITableView *tableView1;
@property (nonatomic , retain) NSMutableArray *mutarrDataList;


@property(nonatomic , strong) ICSDrawerController *drawer;
@end
