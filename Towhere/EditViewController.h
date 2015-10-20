//
//  EditViewController.h
//  Towhere
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "University.h"
#import "Express.h"
#import "Receive.h"
#import "HttpClient.h"

@interface EditViewController : UIViewController<DataLoadStateDelegate>{
    IBOutlet UITextField *name;    //姓名。
    IBOutlet UITextField *phone;   //电话。
    IBOutlet UITextField *address; //地址。
}

-(IBAction)back:(id)sender;
-(IBAction)edit:(id)sender;    //编辑。

-(IBAction)sf:(id)sender;      //省份。
-(IBAction)sq:(id)sender;      //市区。
@property (nonatomic , strong) IBOutlet UIButton *sf;
@property (nonatomic , strong) IBOutlet UIButton *sq;

@property (nonatomic , strong) University *university;
@property (nonatomic , strong) Express *expres;
@property (nonatomic , strong) Receive *receive;

@end
