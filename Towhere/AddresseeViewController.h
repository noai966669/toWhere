//
//  AddresseeViewController.h
//  Towhere
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveAdd.h"

@interface AddresseeViewController : UIViewController{
    IBOutlet UITextField *name;     //姓名。
    IBOutlet UITextField *phone;    //电话。
    IBOutlet UITextField *address;  //地址。
}

@property (nonatomic , weak) IBOutlet UILabel *titleLabel;   //添加收件人/寄件人。
@property (nonatomic , weak) IBOutlet UILabel *nameLabel;    //姓名。
@property (nonatomic , weak) IBOutlet UILabel *phoneLabel;   //电话。
@property (nonatomic , weak) IBOutlet UILabel *addressLabel; //地址。

-(IBAction)back:(id)sender;
-(IBAction)sf:(id)sender;      //选择省份。
-(IBAction)sq:(id)sender;      //选择市区。
@property (nonatomic , strong) IBOutlet UIButton *sf;
@property (nonatomic , strong) IBOutlet UIButton *sq;

@property (nonatomic , strong) SaveAdd *saveAdd;

-(IBAction)saveadd:(id)sender;     //已存收件人。
-(IBAction)finish:(id)sender;      //完成。

@end
