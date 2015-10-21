//
//  WaitSendCell.m
//  Towhere
//
//  Created by apple on 15/7/28.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "WaitSendCell.h"

@implementation WaitSendCell

@synthesize daname = _daname;
@synthesize time = _time;
@synthesize paname = _paname;
@synthesize daaddress = _daaddress;
@synthesize companyname = _companyname;
@synthesize weight = _weight;
@synthesize price = _price;
@synthesize paphone = _paphone;
@synthesize waitsendID = _waitsendID;
@synthesize kdnumber = _kdnumber;
@synthesize status = _status;
@synthesize statusid = _statusid;
@synthesize daid = _daid;
@synthesize paid = _paid;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
