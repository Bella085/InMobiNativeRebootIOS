//
//  SimpleTableCell.m
//  ToDoListApp
//
//  Created by Ankit Mittal on 22/07/15.
//  Copyright (c) 2015 Inmobi. All rights reserved.
//

#import "InFeedTableCell.h"

@implementation InFeedTableCell

@synthesize iconImageView = _iconImageView;
@synthesize primaryImageView = _primaryImageView;
@synthesize titleLabel = _titleLabel;
@synthesize subTitleLabel = _subTitleLabel;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize ctaLabel = _ctaLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
