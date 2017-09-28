//
//  BannerViewController.h
//  InMobiNativeRebootIOS
//
//  Copyright © 2016 InMobi. All rights reserved.
//

//@import InMobiSDK.IMBanner;
//@import InMobiSDK.IMBannerDelegate;

#import <UIKit/UIKit.h>
#import <InMobiSDK/InMobiSDK.h>

@interface BannerViewController : UIViewController <IMBannerDelegate>
@property (nonatomic, strong) IMBanner *banner;
@property (nonatomic) long long placementID;

@end

