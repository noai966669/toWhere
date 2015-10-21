//
//  ExpressCell.h
//  Towhere
//
//  Created by apple on 15/8/12.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpressCell : UITableViewCell

@property (nonatomic , weak) IBOutlet UILabel *companyname;   //快递公司。
@property (nonatomic , weak) IBOutlet UILabel *companyid;     //快递公司编号。
@property (nonatomic , weak) IBOutlet UILabel *code;          //快递公司代码。

@end
