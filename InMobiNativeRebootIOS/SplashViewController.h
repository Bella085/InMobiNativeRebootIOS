//
//  SplashViewController.h
//  InMobiSupply2.0
//
//  Created by Ankit Mittal on 7/4/16.
//  Copyright © 2016 Inmobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <InMobiSDK/InMobiSDK.h>

@interface SplashViewController : UIViewController <IMNativeDelegate>
@property(nonatomic,strong) IMNative *InMobiNativeAd;
@property (nonatomic) long long placementID;
@end
