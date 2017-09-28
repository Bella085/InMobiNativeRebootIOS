//  InFeedTableCell.h
//  Created by Ankit Mittal on 22/07/15.
//  Copyright (c) 2015 Inmobi. All rights reserved.

#import <UIKit/UIKit.h>

@interface InFeedTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic, weak) IBOutlet UIImageView *primaryImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *subTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *ctaLabel;



@end
