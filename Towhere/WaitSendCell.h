//
//  WaitSendCell.h
//  Towhere
//
//  Created by apple on 15/7/28.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitSendCell : UITableViewCell

@property (nonatomic , weak) IBOutlet UILabel *daname;       //收件人姓名。
@property (nonatomic , weak) IBOutlet UILabel *daaddress;    //收件人地址。
@property (nonatomic , weak) IBOutlet UILabel *time;         //时间。
@property (nonatomic , weak) IBOutlet UILabel *paname;       //寄件人姓名。
@property (nonatomic , weak) IBOutlet UILabel *companyname;  //快递公司。
@property (nonatomic , weak) IBOutlet UILabel *weight;       //重量。
@property (nonatomic , weak) IBOutlet UILabel *price;        //价格。
@property (nonatomic , weak) IBOutlet UILabel *paphone;      //寄件人电话。
@property (nonatomic , weak) IBOutlet UILabel *waitsendID;   //待寄id。
@property (nonatomic , weak) IBOutlet UILabel *kdnumber;     //快递单号。
@property (nonatomic , weak) IBOutlet UILabel *status;       //快递状态。
@property (nonatomic , weak) IBOutlet UILabel *statusid;     //状态编号。
@property (nonatomic , weak) IBOutlet UILabel *daid;         //收件人id。
@property (nonatomic , weak) IBOutlet UILabel *paid;         //寄件人id。

@end
