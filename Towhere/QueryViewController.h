//
//  QueryViewController.h
//  Towhere
//
//  Created by apple on 15/7/16.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpClient.h"
#import "ICSDrawerController.h"

@interface QueryViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate,UIAlertViewDelegate,DataLoadStateDelegate,ICSDrawerControllerChild, ICSDrawerControllerPresenting>{
    IBOutlet UITextField *number;    //快递单号。
    IBOutlet UITextField *comname;   //快递公司。
}

-(IBAction)myself:(id)sender;     //个人中心。

-(IBAction)com:(id)sender;        //快递公司选择。
-(IBAction)query:(id)sender;      //查询。
-(IBAction)record:(id)sender;     //历史记录。
-(IBAction)close:(id)sender;      //关闭键盘。

//底部导航。
-(IBAction)receive:(id)sender;    //收快递。
-(IBAction)send:(id)sender;       //寄快递。

@property (nonatomic ,strong) IBOutlet UITableView *tableView1;
@property (nonatomic , retain) NSMutableArray *mutarrDataList;

@property(nonatomic, weak) ICSDrawerController *drawer;

@end
