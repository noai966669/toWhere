//
//  SaveAddCell.h
//  Towhere
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaveAddCell : UITableViewCell

@property (nonatomic , weak) IBOutlet UILabel *addID;          //收件人（寄件人）编号。
@property (nonatomic , weak) IBOutlet UILabel *name;           //收件人（寄件人）姓名。
@property (nonatomic , weak) IBOutlet UILabel *phone;          //电话。
@property (nonatomic , weak) IBOutlet UILabel *provincename;   //省份。
@property (nonatomic , weak) IBOutlet UILabel *cityname;       //市区。
@property (nonatomic , weak) IBOutlet UILabel *cityid;         //地区id。
@property (nonatomic , weak) IBOutlet UILabel *address;        //详细地址。

@end
