//
//  PrerollViewController.h
//  InMobiSupply2.0
//
//  Created by Ankit Mittal on 7/4/16.
//  Copyright © 2016 Inmobi. All rights reserved.
//

#import "PrerollViewController.h"

@interface PrerollViewController () <IMNativeDelegate>
@property (nonatomic) CGRect screenRect;
@property (nonatomic) CGFloat screenWidth;
@property (nonatomic) CGFloat screenHeight;
@property (nonatomic) CGFloat temp_screen;

@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UIButton *show_button;
@property (nonatomic,strong) UILabel *pw_label;
@property (nonatomic,strong) UIView *PrerollAdView;

@property (nonatomic,strong) MPMoviePlayerController *MoviePlayer;
@property (nonatomic,strong) UIButton *MoviePlayerCloseButton;
@end

@implementation PrerollViewController

-(void)dealloc {
    [self.InMobiNativeAd recyclePrimaryView];
    self.InMobiNativeAd.delegate = nil;
    self.InMobiNativeAd = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    _pw_label.backgroundColor = [UIColor redColor];
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
    
    [_show_button setTitle:@"Show Preroll Ad" forState:UIControlStateNormal];
    _show_button.frame = CGRectMake(((_screenWidth/2)-80),((_screenHeight*4/5)-20),160,40);
    _show_button.backgroundColor = [UIColor greenColor];
    _show_button.layer.cornerRadius = 8.0f;
    _show_button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    self.show_button.hidden = true;
    
    [self.view addSubview:self.show_button];
    [self.view bringSubviewToFront:self.show_button];
    
    self.InMobiNativeAd = [[IMNative alloc] initWithPlacementId:self.placementID];
    self.InMobiNativeAd.delegate = self;
    [self.InMobiNativeAd load];
    
    _PrerollAdView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _screenWidth, _screenHeight)];
    _PrerollAdView.hidden = true;
    [self.view addSubview:_PrerollAdView];
    
    NSURL *urlString=[NSURL URLWithString:@"https://i.l.inmobicdn.net/ifctpads/IFC/CCN/assets/KygoStoleTheShowfeat1492609018onlinevideocutter1492609592.mp4"];
    _MoviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:urlString];
    _MoviePlayer.scalingMode = MPMovieScalingModeFill;
    _MoviePlayer.view.hidden = true;
    _MoviePlayer.view.transform = CGAffineTransformRotate(_MoviePlayer.view.transform,
                                                                    90.0 * M_PI/180.0);
    _MoviePlayer.view.frame = CGRectMake(0, 0, _screenWidth, _screenHeight);
    [self.view addSubview:_MoviePlayer.view];
    
    _MoviePlayerCloseButton = [[UIButton alloc] init];
    _MoviePlayerCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_MoviePlayerCloseButton addTarget:self
                     action:@selector(closeMoviePlayer)
           forControlEvents:UIControlEventTouchUpInside];
    
    [_MoviePlayerCloseButton setTitle:@"Close" forState:UIControlStateNormal];
    _MoviePlayerCloseButton.transform = CGAffineTransformRotate(_MoviePlayerCloseButton.transform,90.0 * M_PI/180.0);
    _MoviePlayerCloseButton.backgroundColor = [UIColor lightGrayColor];
    _MoviePlayerCloseButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    _MoviePlayerCloseButton.hidden = true;
    _MoviePlayerCloseButton.frame = CGRectMake((_screenWidth-60),(_screenHeight-100),40,80);
    [self.view addSubview:_MoviePlayerCloseButton];
    
    [self.view bringSubviewToFront:_MoviePlayer.view];
    [self.view bringSubviewToFront:_MoviePlayerCloseButton];
    [self.view bringSubviewToFront:_PrerollAdView];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate{
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

//App Code
-(void)showAd{
    UIView* AdPrimaryViewOfCorrectWidth = [_InMobiNativeAd primaryViewOfWidth:_screenHeight];
    CGFloat degreesOfRotation = 90.0;
    AdPrimaryViewOfCorrectWidth.transform = CGAffineTransformRotate(AdPrimaryViewOfCorrectWidth.transform,
                                             degreesOfRotation * M_PI/180.0);
    AdPrimaryViewOfCorrectWidth.frame = CGRectMake(0, 0, _screenWidth, _screenHeight);
    [AdPrimaryViewOfCorrectWidth setBackgroundColor:[UIColor redColor]];
    [_PrerollAdView addSubview:AdPrimaryViewOfCorrectWidth];
    self.navigationController.navigationBar.layer.zPosition = -1;
    _PrerollAdView.hidden = false;
    self.show_button.hidden = true;
}

-(void)dismissAd{
    _PrerollAdView.hidden = true;
    self.navigationController.navigationBar.layer.zPosition = 0;
    [_InMobiNativeAd recyclePrimaryView];
    _InMobiNativeAd = nil;
    self.InMobiNativeAd = [[IMNative alloc] initWithPlacementId:self.placementID];
    self.InMobiNativeAd.delegate = self;
    [self.InMobiNativeAd load];
    [self.MoviePlayer play];
    self.navigationController.navigationBar.layer.zPosition = -1;
    _MoviePlayer.view.hidden = false;
    _MoviePlayerCloseButton.hidden = false;
}

-(void)closeMoviePlayer{
    [_MoviePlayer stop];
    _MoviePlayer.view.hidden = true;
    _MoviePlayerCloseButton.hidden = true;
    self.navigationController.navigationBar.layer.zPosition = 0;
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
    self.show_button.hidden = false;
}
/*The native ad notifies its delegate that an error has been encountered while trying to load the ad.Check IMRequestStatus.h for all possible errors.Try loading the ad again, later.*/
-(void)native:(IMNative*)native didFailToLoadWithError:(IMRequestStatus*)error{
    NSLog(@"Native Ad load Failed");
}
/* Indicates that the native ad is going to present a screen. */ -(void)nativeWillPresentScreen:(IMNative*)native{
    NSLog(@"Native Ad will present screen");
}
/* Indicates that the native ad has presented a screen. */
-(void)nativeDidPresentScreen:(IMNative*)native{
    NSLog(@"Native Ad did present screen");
}
/* Indicates that the native ad is going to dismiss the presented screen. */
-(void)nativeWillDismissScreen:(IMNative*)native{
    NSLog(@"Native Ad will dismiss screen");
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
    [self dismissAd];
}

@end
