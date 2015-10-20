//
//  ShiquViewController.h
//  Towhere
//
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPersonnelViewController.h"
#import "EditViewController.h"
#import "HttpClient.h"

@interface ShiquViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate,UIAlertViewDelegate,DataLoadStateDelegate>{
    AddPersonnelViewController *myAddPersonnnelViewController;
    EditViewController *myEditViewController;
}

-(IBAction)back:(id)sender;

@property (nonatomic , strong) AddPersonnelViewController *myAddPersonnnelViewController;
@property (nonatomic , strong) EditViewController *myEditViewController;
@property (nonatomic , strong) IBOutlet UITableView *tableView1;
@property (nonatomic , retain) NSMutableArray *mutarrDataList;

@end
