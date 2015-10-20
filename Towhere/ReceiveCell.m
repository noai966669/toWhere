//
//  ReceiveCell.m
//  Towhere
//
//  Created by apple on 15/7/22.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "ReceiveCell.h"
#import "AppDelegate.h"

@implementation ReceiveCell
@synthesize detailLabel = _detailLabel;
@synthesize timeLabel = _timeLabel;

- (void)awakeFromNib {
    // Initialization code
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    if ([appDelegate.cellhight isEqualToString:@"2"]) {
        self.detailLabel.lineBreakMode = NSLineBreakByCharWrapping;    //自动换行。
        self.detailLabel.numberOfLines = 0;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
