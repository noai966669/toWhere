//
//  UniversityViewController.h
//  Towhere
//
//  Created by apple on 15/7/20.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpClient.h"
#import "RegisterdViewController.h"

@interface UniversityViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate,UIAlertViewDelegate,DataLoadStateDelegate>{
    RegisterdViewController *myRegisterdViewController;
}

@property (nonatomic , strong) RegisterdViewController *myRegisterdViewController;
@property (nonatomic , strong) IBOutlet UITableView *tableView1;
@property (nonatomic , retain) NSMutableArray *mutarrDataList;

-(IBAction)back:(id)sender;

@end
