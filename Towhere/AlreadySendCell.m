//
//  AlreadySendCell.m
//  Towhere
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "AlreadySendCell.h"

@implementation AlreadySendCell
@synthesize kdnumber = _kdnumber;
@synthesize daname = _daname;
@synthesize daaddress = _daaddress;
@synthesize companyname = _companyname;
@synthesize paname = _paname;
@synthesize paphone = _paphone;
@synthesize time = _time;
@synthesize weight = _weight;
@synthesize price = _price;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
