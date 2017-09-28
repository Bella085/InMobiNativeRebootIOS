
//  ToDoListTableViewController.m
//  TodoList
//
//  Created by Ankit Mittal on 27/04/15.
//  Copyright (c) 2015 Inmobi. All rights reserved.
//

#import "ToDoListTableViewController.h"

CGFloat cell_height = 0;
CGRect screenRect;
CGFloat screenWidth = 0;
int first_ad_index = 3;

#define kIMAdInsertionPosition 1

#define YOUR_APP_STORE_ID 964395424 // Change this one to your app ID (get it from iTunes Connect)

static NSString *const iOS7AppStoreURLFormat = @"https://itunes.apple.com/app/id%d";


@interface ToDoListTableViewController () <IMNativeStrandsDelegate>
@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, strong) NSMutableArray *objectArray;
@property (nonatomic) BOOL refreshInProgress;
@property (nonatomic) CGFloat layoutHeight;
@property (nonatomic) CGFloat previousScrollViewYOffset;
@property (nonatomic, strong) UIButton *goToTop;

@property(nonatomic,strong) IMNativeStrands *nativeStrands;
@property (nonatomic) BOOL nativeStrandsLoaded,nativeStrandsRendered,nativeStrandsInserted;

@end


@implementation ToDoListTableViewController

- (void)viewDidLoad {
    
    
    //Code for the app
    [super viewDidLoad];
    
    CGRect b = self.view.bounds;
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //center the indicator in the view
    _indicator.frame = CGRectMake((b.size.width - 100) / 2, (b.size.height - 100) / 2, 100, 100);
    [self.view addSubview: _indicator];
    self.tableView.scrollEnabled = NO;
    [_indicator startAnimating];
    
    
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self create_show_more_button];
    self.tableData = [NSMutableArray array];
    self.objectArray = [NSMutableArray array];
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor grayColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(reload_ads)
                  forControlEvents:UIControlEventValueChanged];
    screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    cell_height = (875.0*(screenWidth))/(750.0);
    
    [self Get_the_feed];
    
    self.nativeStrands = [[IMNativeStrands alloc] initWithPlacementId:1460120675397];
    self.nativeStrands.extras=@{@"mk-carrier" : @"61.49.105.27", @"u-appsecure" : @"false", @"u-appbid": @"com.stuckpixelinc.funnypictures"};
    self.nativeStrands.delegate = self;

    
    [self reload_ads];
    
}

- (BOOL)isAdAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.tableData objectAtIndex:indexPath.row] isKindOfClass:[IMNativeStrands class]];
}

-(void)reload_ads{
    [self.nativeStrands load];
}

- (void)viewWillAppear:(BOOL)animated{
    [[self.navigationController.view viewWithTag:9] removeFromSuperview];
    [[self.navigationController.view viewWithTag:900] removeFromSuperview];
    [self create_show_more_button];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.decelerationRate = UIScrollViewDecelerationRateFast;
    tableView.backgroundColor = [UIColor blackColor] ;
    tableView.backgroundView.backgroundColor = [UIColor blackColor] ;
    
    if ([self isAdAtIndexPath:indexPath]) {
        UITableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"adIdentifier"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"adIdentifier"];
        }
        IMNativeStrands *strands = [self.tableData objectAtIndex:indexPath.row];
        [cell addSubview:[strands strandsView]];
        return cell;
    }
    else{
        
        static NSString *simpleTableIdentifier = @"SimpleTableCell";
        SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        id slide = [self.tableData objectAtIndex:indexPath.row];
        SampleData *current_slide = slide;
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        cell.myImageView.contentMode = UIViewContentModeScaleAspectFit;
        cell.myImageView.frame = CGRectMake(0, 0, screenWidth, cell_height);
        cell.myImageView.clipsToBounds = YES;
        cell.myImageView.image = [UIImage imageNamed:current_slide.image_name];
        
        NSInteger lastSectionIndex = [tableView numberOfSections] - 1;
        NSInteger lastRowIndex = 19;
        if ((indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)) {
            [self.goToTop setHidden:NO];
        }
        else if (indexPath.row == 0) {
            [self.goToTop setHidden:YES];
        }
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row!=1){
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:iOS7AppStoreURLFormat, YOUR_APP_STORE_ID]]];
        
        NSLog(@"%@",[NSURL URLWithString:[NSString stringWithFormat:iOS7AppStoreURLFormat, YOUR_APP_STORE_ID]]);
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isAdAtIndexPath:indexPath]) {
     //   return [self.nativeStrands strandsViewSize].height;
        
        return 378;
    }
    return cell_height;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView.indexPathsForVisibleRows indexOfObject:indexPath] == NSNotFound && [self isAdAtIndexPath:indexPath]) {
     //   [self.nativeStrands recycleView];
    }
}

- (void)updateTableData {
    if (!self.nativeStrandsLoaded || self.nativeStrandsInserted) {
        return;
    }
    //    NSArray *visibleArray = self.tableView.indexPathsForVisibleRows;
    //    NSIndexPath *lastVisibleCell = visibleArray.lastObject;
    //    if (kIMAdInsertionPosition > lastVisibleCell.row) {
    self.nativeStrandsInserted = YES;
    [self.tableData insertObject:self.nativeStrands atIndex:kIMAdInsertionPosition];
    [self.tableView reloadData];
    //    }
}

//Functions specific to the app

-(void)create_show_more_button {
    self.goToTop = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.goToTop.frame = CGRectMake((screenRect.size.width)*1/3, 50, (screenRect.size.width)*1/3, 20);
    [self.goToTop setTitle:@"Go to top" forState:UIControlStateNormal];
    [self.goToTop addTarget:self action:@selector(show_more) forControlEvents:UIControlEventTouchUpInside];
    [self.goToTop setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.goToTop.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    self.goToTop.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    self.goToTop.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
    self.goToTop.layer.cornerRadius = 10.0f;
    [self.goToTop setHidden:YES];
    self.goToTop.tag = 900;
    [self.navigationController.view addSubview:self.goToTop];
}

-(void)Get_the_feed {
    
    [self loadInitialData];
    [self loadInitialData];
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointMake(0, 0 - self.tableView.contentInset.top) animated:YES];
}

-(void)show_more {
    NSLog(@"ankit");
    [self.tableView setContentOffset:CGPointMake(0, 0 - self.tableView.contentInset.top) animated:YES];
}

- (void)loadInitialData {
    
    SampleData *item1 = [[SampleData alloc] init];
    item1.image_name = @"n0";
    [self.objectArray addObject:item1];
    SampleData *item2 = [[SampleData alloc] init];
    item2.image_name = @"n1";
    [self.objectArray addObject:item2];
    SampleData *item3 = [[SampleData alloc] init];
    item3.image_name = @"n2";
    [self.objectArray addObject:item3];
    SampleData *item4 = [[SampleData alloc] init];
    item4.image_name = @"n3";
    [self.objectArray addObject:item4];
    SampleData *item5 = [[SampleData alloc] init];
    item5.image_name = @"n4";
    [self.objectArray addObject:item5];
    SampleData *item6 = [[SampleData alloc] init];
    item6.image_name = @"n0";
    [self.objectArray addObject:item6];
    SampleData *item7 = [[SampleData alloc] init];
    item7.image_name = @"n1";
    [self.objectArray addObject:item7];
    SampleData *item8 = [[SampleData alloc] init];
    item8.image_name = @"n2";
    [self.objectArray addObject:item8];
    SampleData *item9 = [[SampleData alloc] init];
    item9.image_name = @"n3";
    [self.objectArray addObject:item9];
    SampleData *item10 = [[SampleData alloc] init];
    item10.image_name = @"n4";
    [self.objectArray addObject:item10];
    
    int indexvalue = 0;
    
    for(; indexvalue<10; indexvalue++)
    {
        [self.tableData insertObject:self.objectArray[indexvalue] atIndex:0];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect frame = self.navigationController.navigationBar.frame;
    CGFloat size = frame.size.height - 21;
    CGFloat framePercentageHidden = ((20 - frame.origin.y) / (frame.size.height - 1));
    CGFloat scrollOffset = scrollView.contentOffset.y;
    CGFloat scrollDiff = scrollOffset - self.previousScrollViewYOffset;
    CGFloat scrollHeight = scrollView.frame.size.height;
    CGFloat scrollContentSizeHeight = scrollView.contentSize.height + scrollView.contentInset.bottom;
    
    if (scrollOffset <= -scrollView.contentInset.top) {
        frame.origin.y = 20;
    } else if ((scrollOffset + scrollHeight) >= scrollContentSizeHeight) {
        frame.origin.y = -size;
    } else {
        frame.origin.y = MIN(20, MAX(-size, frame.origin.y - scrollDiff));
    }
    
    [self.navigationController.navigationBar setFrame:frame];
    [self updateBarButtonItems:(1 - framePercentageHidden)];
    self.previousScrollViewYOffset = scrollOffset;
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableView setContentOffset:CGPointMake(0, -1 - self.tableView.contentInset.top) animated:NO];
    [self.tableView setContentOffset:CGPointMake(0, 0 - self.tableView.contentInset.top) animated:YES];
}

- (void)updateBarButtonItems:(CGFloat)alpha
{
    [self.navigationItem.leftBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem* item, NSUInteger i, BOOL *stop) {
        item.customView.alpha = alpha;
    }];
    [self.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem* item, NSUInteger i, BOOL *stop) {
        item.customView.alpha = alpha;
    }];
    self.navigationItem.titleView.alpha = alpha;
    self.navigationController.navigationBar.tintColor = [self.navigationController.navigationBar.tintColor colorWithAlphaComponent:alpha];
}

- (void)nativeStrands:(IMNativeStrands *)nativeStrands didFailToLoadWithError:(IMRequestStatus *)error {
    NSLog(@"Error : %@",error.description);
    [self.nativeStrands load];
    
}
- (void)nativeStrandsAdClicked:(IMNativeStrands *)nativeStrands {
    NSLog(@"Native Strands Ad Clicked");
}
- (void)nativeStrandsAdImpressed:(IMNativeStrands *)nativeStrands {
    NSLog(@"Native Strands Ad Impression tracked");
}
- (void)nativeStrandsDidDismissScreen:(IMNativeStrands *)nativeStrands {
    NSLog(@"Native Strands will dismiss screen");
}
- (void)nativeStrandsDidFinishLoading:(IMNativeStrands *)nativeStrands {
    self.nativeStrandsLoaded = YES;
    [self updateTableData];
    NSLog(@"Native Strands did finish load");
    
    [_indicator removeFromSuperview];
    _indicator = nil;
    self.tableView.scrollEnabled = YES;
    [self.refreshControl endRefreshing];
}
- (void)nativeStrandsDidPresentScreen:(IMNativeStrands *)nativeStrands {
    NSLog(@"Native Strands did present screen");
}
- (void)nativeStrandsWillDismissScreen:(IMNativeStrands *)nativeStrands {
    NSLog(@"Native Strands will dismiss screen");
}
- (void)nativeStrandsWillPresentScreen:(IMNativeStrands *)nativeStrands {
    NSLog(@"Native Strands will present screen");
}
- (void)userWillLeaveApplicationFromNativeStrands:(IMNativeStrands *)nativeStrands {
    NSLog(@"user will leave application from native strands");
}
- (void)dealloc {
    self.nativeStrands.delegate = nil;
    [self.tableView removeObserver:self
                        forKeyPath:@"contentOffset"
                           context:nil];
}


@end
