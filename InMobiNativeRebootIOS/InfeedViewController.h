//
//  InfeedViewController
//
//  Created by Ankit Mittal on 27/04/15.
//  Copyright (c) 2015 Inmobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InFeedTableCell.h"
#import "SampleData.h"

#import <InMobiSDK/InMobiSDK.h>

@interface InfeedViewController : UITableViewController <IMNativeDelegate>
@property(nonatomic,strong) IMNative *InMobiNativeAd;
@property(nonatomic,strong) IMNative *InMobiNativeAd1;
@property(nonatomic,strong) IMNative *InMobiNativeAd3;
@property(nonatomic,strong) IMNative *InMobiNativeAd5;
@property (nonatomic) long long placementID;
@end
