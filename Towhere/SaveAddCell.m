//
//  SaveAddCell.m
//  Towhere
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "SaveAddCell.h"

@implementation SaveAddCell
@synthesize addID = _addID;
@synthesize name = _name;
@synthesize phone = _phone;
@synthesize provincename = _provincename;
@synthesize cityname = _cityname;
@synthesize cityid = _cityid;
@synthesize address = _address;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
