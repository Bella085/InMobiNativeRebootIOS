//  Created by Ankit Mittal on 27/04/15.
//  Copyright (c) 2015 Inmobi. All rights reserved.
//

#import "BaseTableViewController.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@interface BaseTableViewController ()
@property (nonatomic) CGFloat previousScrollViewYOffset;

@property (nonatomic,strong) NSArray *items;
@property (nonatomic,strong) NSArray *items_image;

@property (nonatomic,strong) InfeedViewController *InfeedVC;
@property (nonatomic,strong) SplashViewController *SplashVC;
@property (nonatomic,strong) PrerollViewController *PrerollVC;
@property (nonatomic,strong) BannerViewController *BannerVC;
@property (nonatomic,strong) InterstitialViewController *InterstitialVC;


@end


@implementation BaseTableViewController

- (void)viewDidLoad {
    
    //Code for the app
    [super viewDidLoad];
    
    
    //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    _items = [[NSArray alloc] init];
    // _items = [NSArray arrayWithObjects:@"Brand Landscape", @"Brand Infeed", @"Brand Vertical",@"Perf Landscape", @"Perf Infeed", @"Perf Portrait", nil];
    _items = [NSArray arrayWithObjects:@"InFeed", @"Splash",@"Preroll", @"Banner", @"Interstitial", nil];
    
    _items_image = [[NSArray alloc] init];
    _items_image = [NSArray arrayWithObjects:@"business", @"social", @"utilities", @"sports", @"travel", nil];
    
    //self.IntVC = [[InterstitialVideoViewController alloc] init];
    //self.InfeedVC = [[InfeedViewController alloc] init];
    
    
}

-(BOOL)shouldAutorotate{
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight;
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
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.decelerationRate = UIScrollViewDecelerationRateFast;
    tableView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    tableView.backgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2) ;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[self.items_image objectAtIndex:indexPath.row]];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.InfeedVC = [[UIStoryboard storyboardWithName:@"Main" bundle: nil] instantiateViewControllerWithIdentifier:@"InfeedViewController"];
    self.SplashVC = [[UIStoryboard storyboardWithName:@"Main" bundle: nil] instantiateViewControllerWithIdentifier:@"SplashViewController"];
    self.PrerollVC = [[UIStoryboard storyboardWithName:@"Main" bundle: nil] instantiateViewControllerWithIdentifier:@"PrerollViewController"];
    self.BannerVC = [[UIStoryboard storyboardWithName:@"Main" bundle: nil] instantiateViewControllerWithIdentifier:@"BannerViewController"];
    self.InterstitialVC = [[UIStoryboard storyboardWithName:@"Main" bundle: nil] instantiateViewControllerWithIdentifier:@"InterstitialViewController"];
    
    switch (indexPath.row)
    {
        case 0:
            self.InfeedVC.placementID = 1500142171333;
            [self.navigationController pushViewController:self.InfeedVC animated:YES];
            break;
        case 1:
            self.SplashVC.placementID = 1503896599914;
            [self.navigationController pushViewController:self.SplashVC animated:YES];
            break;
        case 2:
            self.PrerollVC.placementID = 1503220506087;
            [self.navigationController pushViewController:self.PrerollVC animated:YES];
            break;
        case 3:
            self.BannerVC.placementID = 1502800773034;
            [self.navigationController pushViewController:self.BannerVC animated:YES];
            break;
        default:
            self.InterstitialVC.placementID = 1504861055938;
            [self.navigationController pushViewController:self.InterstitialVC animated:YES];
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)updateTableData {
    [self.tableView reloadData];
}

//Functions specific to the app


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}

-(void)viewDidAppear:(BOOL)animated{
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

- (void)dealloc {
    NSLog(@"Base is dealloc");
}

@end
