
//  InfeedViewController.m
//  TodoList
//
//  Created by Ankit Mittal on 27/04/15.
//  Copyright (c) 2015 Inmobi. All rights reserved.
//

#import "InfeedViewController.h"

#import <AVFoundation/AVFoundation.h>

#define kIMAdInsertionPosition 1
CGFloat primaryImageViewWidth = 0;
CGRect primaryImageViewFrame;

@interface InfeedViewController () <IMNativeDelegate>
@property (nonatomic) CGRect screenRect;
@property (nonatomic) CGFloat screenWidth;

@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, strong) UIGestureRecognizer *AdClick;
@end

@interface IMUIVideoView : UIView
@property (nonatomic, strong) AVPlayer* player;
@end

@implementation InfeedViewController

-(void)dealloc {
    [self.InMobiNativeAd recyclePrimaryView];
    self.InMobiNativeAd.delegate = nil;
    self.InMobiNativeAd = nil;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableData = [NSMutableArray array];
    
    _screenRect = [[UIScreen mainScreen] bounds];
    _screenWidth = _screenRect.size.width;
    [self loadInitialData];
    [self loadInitialData];
    self.InMobiNativeAd1 = [[IMNative alloc] initWithPlacementId:self.placementID];
    self.InMobiNativeAd1.delegate = self;
    [self.InMobiNativeAd1 load];
    [self loadInitialData];
    self.InMobiNativeAd3 = [[IMNative alloc] initWithPlacementId:self.placementID];
    self.InMobiNativeAd3.delegate = self;
    [self.InMobiNativeAd3 load];
    [self loadInitialData];
    self.InMobiNativeAd5 = [[IMNative alloc] initWithPlacementId:self.placementID];
    self.InMobiNativeAd5.delegate = self;
    [self.InMobiNativeAd5 load];
    [self loadInitialData];
    [self.tableView reloadData];
    
 
    self.InMobiNativeAd = [[IMNative alloc] initWithPlacementId:self.placementID];
    self.InMobiNativeAd.delegate = self;
    [self.InMobiNativeAd load];
    
    self.tableView.estimatedRowHeight = 500;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
}

- (BOOL)isAdAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.tableData objectAtIndex:indexPath.row] isKindOfClass:[IMNative class]];
}

- (void)viewWillAppear:(BOOL)animated{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    InFeedTableCell *tableCell = (InFeedTableCell *)cell;
    [tableCell layoutIfNeeded];
    primaryImageViewWidth =  tableCell.primaryImageView.frame.size.width;
    primaryImageViewFrame = tableCell.primaryImageView.frame;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.decelerationRate = UIScrollViewDecelerationRateFast;
    tableView.backgroundColor = [UIColor blackColor];
    tableView.backgroundView.backgroundColor = [UIColor blackColor];
    
    InFeedTableCell *cell = (InFeedTableCell *)[tableView dequeueReusableCellWithIdentifier:@"InFeedTableCell"];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"InFeedTableCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
    
    [cell layoutIfNeeded];
    
    id slide = [self.tableData objectAtIndex:indexPath.row];
    
    if ([self isAdAtIndexPath:indexPath]) {
        
        IMNative *currentNativeAd = slide;
    

        cell.iconImageView.image = currentNativeAd.adIcon;
        cell.titleLabel.text = [currentNativeAd adTitle];
        cell.subTitleLabel.text = @"Sponsored";
        cell.descriptionLabel.text = currentNativeAd.adDescription;
        cell.ctaLabel.text = currentNativeAd.adCtaText;
        cell.primaryImageView.image = [UIImage imageNamed:@"placeholder.png"];

        UIView* adContainerView = [[UIView alloc] initWithFrame:primaryImageViewFrame];
        UIView* AdPrimaryViewOfCorrectWidth = [currentNativeAd primaryViewOfWidth:primaryImageViewWidth];
        [AdPrimaryViewOfCorrectWidth setBackgroundColor:[UIColor whiteColor]];
        [adContainerView addSubview:AdPrimaryViewOfCorrectWidth];
        [cell addSubview:adContainerView];
        return cell;
    }
    else {
        SampleData *appContentSlide = slide;
        cell.titleLabel.text = appContentSlide.titleText;
        cell.subTitleLabel.text = appContentSlide.subtitleText;
        cell.descriptionLabel.text = appContentSlide.descriptionText;
        cell.ctaLabel.text = appContentSlide.ctaText;
        cell.iconImageView.image = [UIImage imageNamed:appContentSlide.iconImageName];
        cell.primaryImageView.image = [UIImage imageNamed:appContentSlide.primaryImageName];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(printClickLog)];
        cell.iconImageView.userInteractionEnabled = YES;
        [cell.iconImageView addGestureRecognizer:singleTap];
        return cell;
    }
}

-(void)printClickLog{
    NSLog(@"Content Clicked");
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0)
    {
        [self refreshAd];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(void)refreshAd{
    [self.tableData removeObject:self.InMobiNativeAd];
    [self.tableView reloadData];
    [self.InMobiNativeAd recyclePrimaryView];
    self.InMobiNativeAd = [[IMNative alloc] initWithPlacementId:self.placementID];
    self.InMobiNativeAd.delegate = self;
//    [self.InMobiNativeAd shouldOpenLandingPage:NO];
    [self.InMobiNativeAd load];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self isAdAtIndexPath:indexPath])
    {
        [self.InMobiNativeAd recyclePrimaryView];
    }
}

/*The native ad notifies its delegate that it is ready. Fetching publisher-specific ad asset content from native.adContent. The publisher will specify the format. If the publisher does not provide a format, no ad will be loaded.*/
-(void)nativeDidFinishLoading:(IMNative*)native{
    int x = arc4random() % 8;
    [self.tableData insertObject:native atIndex:x];
    [self.tableView reloadData];
}
/*The native ad notifies its delegate that an error has been encountered while trying to load the ad.Check IMRequestStatus.h for all possible errors.Try loading the ad again, later.*/
-(void)native:(IMNative*)native didFailToLoadWithError:(IMRequestStatus*)error{
    NSLog(@"Native Ad load Failed");
}
/* Indicates that the native ad is going to present a screen. */ -(void)nativeWillPresentScreen:(IMNative*)native{
    NSLog(@"Native Ad will present screen"); //Full Screen experience
}
/* Indicates that the native ad has presented a screen. */
-(void)nativeDidPresentScreen:(IMNative*)native{
    NSLog(@"Native Ad did present screen"); //Full Screen experience
}
/* Indicates that the native ad is going to dismiss the presented screen. */
-(void)nativeWillDismissScreen:(IMNative*)native{
    NSLog(@"Native Ad will dismiss screen"); //Full Screen experience
}
/* Indicates that the native ad has dismissed the presented screen. */
-(void)nativeDidDismissScreen:(IMNative*)native{
    NSLog(@"Native Ad did dismiss screen"); //Full Screen experience
}
/* Indicates that the user will leave the app. */
-(void)userWillLeaveApplicationFromNative:(IMNative*)native{
    NSLog(@"User leave"); //CTA External
}

-(void)native:(IMNative *)native didInteractWithParams:(NSDictionary *)params{
    NSLog(@"User clicked the ad"); // Click Counting
}

-(void)nativeAdImpressed:(IMNative *)native{
    NSLog(@"Impression was counted"); // Impression Counting
}

-(void)native:(IMNative *)native rewardActionCompletedWithRewards:(NSDictionary *)rewards{
    NSLog(@"User can be rewarded"); //Rewarded
}

/**
 * Notifies the delegate that the native ad has finished playing media.
 */
-(void)nativeDidFinishPlayingMedia:(IMNative*)native{
    NSLog(@"The Video has finished playing");
    //PreRoll Use Case
}

- (void)loadInitialData {
    
    SampleData *item1 = [[SampleData alloc] init];
    item1.titleText = @"Neha Jha";
    item1.subtitleText = @"Product Manager";
    item1.descriptionText = @"Looking out for a Sponsorship Manager with 5+ yrs exp for a sports tourism company in Bangalore with strong grasp of media planning principles & excellent understanding of target segment, market intelligence and media medium technicalities. For more infos contact me at neha@zyoin.com";
    item1.iconImageName = @"neha_jha.jpg";
    item1.primaryImageName = @"neha_jha_big.png";
    item1.ctaText = @"Know More";
    [self.tableData addObject:item1];
    
    SampleData *item2 = [[SampleData alloc] init];
    item2.titleText = @"Nazia Firdose";
    item2.subtitleText = @"HR";
    item2.descriptionText = @"Please pray for these children in Syria after the death of their mother. The oldest sister has to take care of her younger siblings. -Ayad L Gorgees. ***Please don't scroll past without Typing Amen! because they need our prayers!!";
    item2.iconImageName = @"nazia.jpg";
    item2.primaryImageName = @"nazia_big.png";
    item2.ctaText = @"Know More";
    [self.tableData addObject:item2];
    
    SampleData *item3 = [[SampleData alloc] init];
    item3.titleText = @"Dharmesh Shah";
    item3.subtitleText = @"Founder at HubSpot";
    item3.descriptionText = @"Why, dear God, haven't you started marketing yet? http://dharme.sh/1Ewu63k by @gjain via @Inboundorg";
    item3.iconImageName = @"dharmesh.jpg";
    item3.primaryImageName = @"dharmesh_big.png";
    item3.ctaText = @"Know More";
    [self.tableData addObject:item3];
    
    SampleData *item4 = [[SampleData alloc] init];
    item4.titleText = @"Piyush Shah";
    item4.subtitleText = @"CPO";
    item4.descriptionText = @"With mobile being accepted as the definitive medium to access consumers’ minds and wallets, Brands have begun a multi-million dollar spending race to allure and retain customers.  Read on: https://lnkd.in/e8mcUfc";
    item4.iconImageName = @"piyush.jpg";
    item4.primaryImageName = @"piyush_big.png";
    item4.ctaText = @"Know More";
    [self.tableData addObject:item4];
    
    SampleData *item5 = [[SampleData alloc] init];
    item5.titleText = @"Jeff Weiner";
    item5.subtitleText = @"CEO at Linkedin";
    item5.descriptionText = @"Honored to represent LinkedIn's Economic Graph capabilities at the White House earlier today and partnering to Upskill America.";
    item5.iconImageName = @"jeff.jpg";
    item5.primaryImageName = @"jeff_big.png";
    item5.ctaText = @"Know More";
    [self.tableData addObject:item5];
    
    
}



@end
