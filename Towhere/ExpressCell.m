//
//  ExpressCell.m
//  Towhere
//
//  Created by apple on 15/8/12.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "ExpressCell.h"

@implementation ExpressCell
@synthesize companyname = _companyname;
@synthesize companyid = _companyid;
@synthesize code = _code;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
