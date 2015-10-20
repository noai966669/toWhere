//
//  UniversityCell.m
//  Towhere
//
//  Created by apple on 15/7/20.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "UniversityCell.h"

@implementation UniversityCell

@synthesize nameLabel = _nameLabel;
@synthesize uidLabel = _uidLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
