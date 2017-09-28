//
//  PrerollViewController.h
//  InMobiNativeRebootIOS
//
//  Created by Ankit Mittal on 4/19/17.
//  Copyright © 2017 Inmobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <InMobiSDK/InMobiSDK.h>

@interface PrerollViewController : UIViewController <IMNativeDelegate>
@property(nonatomic,strong) IMNative *InMobiNativeAd;
@property (nonatomic) long long placementID;
@end
