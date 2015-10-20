//
//  SaveAddViewController.h
//  Towhere
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddresseeViewController.h"
#import "HttpClient.h"

@interface SaveAddViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate,UIAlertViewDelegate,DataLoadStateDelegate>{
    AddresseeViewController *myAddresseeViewCOntroller;
}

-(IBAction)back:(id)sender;
-(IBAction)add:(id)sender;     //新增。

@property (nonatomic , strong) AddresseeViewController *myAddresseeViewController;
@property (nonatomic , strong) IBOutlet UITableView *tableView1;
@property (nonatomic , retain) NSMutableArray *mutarrDataList;

@end
