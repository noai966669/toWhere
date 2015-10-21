//
//  SendViewController.h
//  Towhere
//
//  Created by apple on 15/7/16.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpClient.h"
#import "WaitSendViewController.h"
#import "ICSDrawerController.h"

@interface SendViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate,UIAlertViewDelegate,DataLoadStateDelegate,ICSDrawerControllerChild, ICSDrawerControllerPresenting>{
    WaitSendViewController *myWaitSendViewController;
}

-(IBAction)myself:(id)sender;      //个人中心。
-(IBAction)wantsend:(id)sender;    //我要寄快递。

-(IBAction)waitsend:(id)sender;     //待寄。
-(IBAction)alreadysend:(id)sender;  //已寄。
@property (nonatomic , strong) IBOutlet UIButton *waitsend;      //图片转换。
@property (nonatomic , strong) IBOutlet UIButton *alreadysend;   


@property (nonatomic , strong) WaitSendViewController *myWaitSendViewController;
@property (nonatomic , strong) IBOutlet UITableView *tableView1;
@property (nonatomic , retain) NSMutableArray *mutarrDataList;

//底部导航。
-(IBAction)receive:(id)sender;    //收快递。
-(IBAction)query:(id)sender;      //查询。

@property(nonatomic , strong) ICSDrawerController *drawer;

@end
