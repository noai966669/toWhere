//
//  ExpressViewController.h
//  Towhere
//
//  Created by apple on 15/8/12.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WantSendViewController.h"
#import "HttpClient.h"

@interface ExpressViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate,UIAlertViewDelegate,DataLoadStateDelegate>{
    WantSendViewController *myWantSendViewController;
}

-(IBAction)back:(id)sender;

@property (nonatomic , strong) WantSendViewController *myWantSendViewController;
@property (nonatomic , strong) IBOutlet UITableView *tableView1;
@property (nonatomic , retain) NSMutableArray *mutarrDataList;

@end
