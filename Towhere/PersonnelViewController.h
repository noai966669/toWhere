//
//  PersonnelViewController.h
//  Towhere
//
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpClient.h"
#import "EditViewController.h"


@interface PersonnelViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate,UIAlertViewDelegate,DataLoadStateDelegate>{
    EditViewController *myEditViewController;
}

-(IBAction)back:(id)sender;
-(IBAction)addressee:(id)sender;     //收件人按钮。
-(IBAction)post:(id)sender;          //寄件人按钮。
//收寄件人图片转换。
@property (nonatomic , strong) IBOutlet UIButton *addressee;
@property (nonatomic , strong) IBOutlet UIButton *post;

-(IBAction)add:(id)sender;           //添加。

@property (nonatomic ,strong) EditViewController *myEditViewController;
@property (nonatomic ,strong) IBOutlet UITableView *tableView1;
@property (nonatomic , retain) NSMutableArray *mutarrDataList;


@end
