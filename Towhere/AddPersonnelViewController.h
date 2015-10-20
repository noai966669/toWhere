//
//  AddPersonnelViewController.h
//  Towhere
//
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "University.h"
#import "Express.h"
#import "HttpClient.h"

@interface AddPersonnelViewController : UIViewController<DataLoadStateDelegate>{
    IBOutlet UITextField *name;     //姓名。
    IBOutlet UITextField *phone;    //电话。
    IBOutlet UITextField *address;  //地址。
}

@property (nonatomic , weak) IBOutlet UILabel *titleLabel;   //标题。 添加收/寄件人。

-(IBAction)back:(id)sender;
-(IBAction)add:(id)sender;     //新增。

-(IBAction)sf:(id)sender;      //选择省份。
-(IBAction)sq:(id)sender;      //选择市区。
@property (nonatomic , strong) IBOutlet UIButton *sf;
@property (nonatomic , strong) IBOutlet UIButton *sq;

@property (nonatomic , strong) University *university;
@property (nonatomic , strong) Express *expres;

@end
