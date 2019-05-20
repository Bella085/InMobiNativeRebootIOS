//
//  SplashViewController.h
//  InMobiSupply2.0
//
//  Created by Ankit Mittal on 7/4/16.
//  Copyright © 2016 Inmobi. All rights reserved.
//

#import "SplashViewController.h"

BOOL isSecondScreenDisplayed;

@interface SplashViewController () <IMNativeDelegate>
@property (nonatomic) CGRect screenRect;
@property (nonatomic) CGFloat screenWidth;
@property (nonatomic) CGFloat screenHeight;
@property (nonatomic) CGFloat temp_screen;

@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UIButton *show_button;
@property (nonatomic,strong) UILabel *pw_label;
@property (nonatomic,strong) UIView *SplashAdView;

@end

@implementation SplashViewController

-(void)dealloc {
    [self.InMobiNativeAd recyclePrimaryView];
    self.InMobiNativeAd.delegate = nil;
    self.InMobiNativeAd = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    isSecondScreenDisplayed = NO;
    _screenRect = [[UIScreen mainScreen] bounds];
    _screenWidth = _screenRect.size.width;
    _screenHeight = _screenRect.size.height;
    
    self.backgroundView = [[UIImageView alloc] init];
    [self.backgroundView setImage:[UIImage imageNamed:@"app_back"]];
    self.backgroundView.frame = CGRectMake(0, 0, _screenWidth, _screenHeight);
    self.backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view addSubview:self.backgroundView];
    [self.view sendSubviewToBack:self.backgroundView];
    
    //Please wait Label
    _pw_label = [[UILabel alloc] initWithFrame:CGRectMake(((_screenWidth/2)-120),((_screenHeight*2/3)-60),240,80)];
    _pw_label.textColor = [UIColor whiteColor];
    _pw_label.backgroundColor = [UIColor clearColor];
    _pw_label.layer.cornerRadius = 20.0f;
    _pw_label.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    _pw_label.hidden = YES;
    _pw_label.numberOfLines = 0;
    _pw_label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_pw_label];
    
    _show_button = [[UIButton alloc] init];
    _show_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_show_button addTarget:self
                     action:@selector(showAd)
           forControlEvents:UIControlEventTouchUpInside];
    
    [_show_button setTitle:@"Show Splash Ad" forState:UIControlStateNormal];
    _show_button.frame = CGRectMake(((_screenWidth/2)-80),((_screenHeight*4/5)-20),160,40);
    _show_button.backgroundColor = [UIColor greenColor];
    _show_button.layer.cornerRadius = 8.0f;
    _show_button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    self.show_button.hidden = true;
    
    [self.view addSubview:self.show_button];
    [self.view bringSubviewToFront:self.show_button];
    
    self.InMobiNativeAd = [[IMNative alloc] initWithPlacementId:self.placementID];
    self.InMobiNativeAd.delegate = self;
    
//    [self.InMobiNativeAd shouldOpenLandingPage:NO];
    [self.InMobiNativeAd load];
    [self performSelector:@selector(ShowIfSplashAdIsReady) withObject:NULL afterDelay:2.0];
    
    _SplashAdView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _screenWidth, _screenHeight)];
    _SplashAdView.hidden = true;
    [self.view addSubview:_SplashAdView];
    [self.view bringSubviewToFront:_SplashAdView];
    
}

-(void)viewDidAppear:(BOOL)animated{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate{
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)ShowIfSplashAdIsReady{
    if(self.InMobiNativeAd.isReady)
    {
        self.show_button.hidden = false;
    }
    else
    {
        [self ShowMessage:@"Not enough time to load ad" dismissAfter:2.0];
    }
}

-(void)showAd{
    UIView* AdPrimaryViewOfCorrectWidth = [_InMobiNativeAd primaryViewOfWidth:_screenWidth];
    [AdPrimaryViewOfCorrectWidth setBackgroundColor:[UIColor redColor]];
    [_SplashAdView addSubview:AdPrimaryViewOfCorrectWidth];
    self.navigationController.navigationBar.layer.zPosition = -1;
    _SplashAdView.hidden = false;
    self.show_button.hidden = true;
    [self performSelector:@selector(dismissAd) withObject:NULL afterDelay:6.0];
}

-(void)dismissAd{
    if(isSecondScreenDisplayed){
        NSLog(@"DO NOT DISMISS THE AD WHILE THE SCREEN IS BEING DISPLAYED");
    }
    else
    {
        _SplashAdView.hidden = true;
        self.navigationController.navigationBar.layer.zPosition = 0;
        [_InMobiNativeAd recyclePrimaryView];
        _InMobiNativeAd = nil;
        self.InMobiNativeAd = [[IMNative alloc] initWithPlacementId:self.placementID];
        self.InMobiNativeAd.delegate = self;
        [self.InMobiNativeAd load];
    }
}

- (void)ShowMessage:(NSString *)message dismissAfter:(NSTimeInterval)interval
{
    _pw_label.text = message;
    _pw_label.hidden = FALSE;
    [self performSelector:@selector(dismissAfterDelay) withObject:nil afterDelay:interval];
}

- (void)dismissAfterDelay
{
    _pw_label.hidden = TRUE;
    // [self dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    // Code here will execute before the rotation begins.
    // Equivalent to placing it in the deprecated method -[willRotateToInterfaceOrientation:duration:]
    _temp_screen = _screenHeight;
    _screenHeight = _screenWidth;
    _screenWidth = _temp_screen;
    self.backgroundView.frame = CGRectMake(0, 0, _screenWidth, _screenHeight);
    self.pw_label.frame = CGRectMake(((_screenWidth/2)-120),((_screenHeight*2/3)-60),240,80);
    _show_button.frame = CGRectMake(((_screenWidth/2)-80),((_screenHeight*4/5)-20),160,40);
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        // Place code here to perform animations during the rotation.
        // You can pass nil or leave this block empty if not necessary.
        
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        // Code here will execute after the rotation has finished.
        // Equivalent to placing it in the deprecated method -[didRotateFromInterfaceOrientation:]
        
    }];
}

/*The native ad notifies its delegate that it is ready. Fetching publisher-specific ad asset content from native.adContent. The publisher will specify the format. If the publisher does not provide a format, no ad will be loaded.*/
-(void)nativeDidFinishLoading:(IMNative*)native{
    NSLog(@"Native Ad load Successful");
}
/*The native ad notifies its delegate that an error has been encountered while trying to load the ad.Check IMRequestStatus.h for all possible errors.Try loading the ad again, later.*/
-(void)native:(IMNative*)native didFailToLoadWithError:(IMRequestStatus*)error{
    NSLog(@"Native Ad load Failed");
    [self ShowMessage:@"No Fill OR Response Error" dismissAfter:2.0];
}
/* Indicates that the native ad is going to present a screen. */ -(void)nativeWillPresentScreen:(IMNative*)native{
    NSLog(@"Native Ad will present screen");
    isSecondScreenDisplayed = YES;
}
/* Indicates that the native ad has presented a screen. */
-(void)nativeDidPresentScreen:(IMNative*)native{
    NSLog(@"Native Ad did present screen");
}
/* Indicates that the native ad is going to dismiss the presented screen. */
-(void)nativeWillDismissScreen:(IMNative*)native{
    NSLog(@"Native Ad will dismiss screen");
    isSecondScreenDisplayed = NO;
    [self dismissAd];
}
/* Indicates that the native ad has dismissed the presented screen. */
-(void)nativeDidDismissScreen:(IMNative*)native{
    NSLog(@"Native Ad did dismiss screen");
}
/* Indicates that the user will leave the app. */
-(void)userWillLeaveApplicationFromNative:(IMNative*)native{
    NSLog(@"User leave");
}

-(void)native:(IMNative *)native didInteractWithParams:(NSDictionary *)params{
    NSLog(@"User leave");
}

-(void)nativeAdImpressed:(IMNative *)native{
    NSLog(@"User leave");
}

-(void)native:(IMNative *)native rewardActionCompletedWithRewards:(NSDictionary *)rewards{
    NSLog(@"User leave");
}

-(void)nativeDidFinishPlayingMedia:(IMNative *)native{
    
}

@end
