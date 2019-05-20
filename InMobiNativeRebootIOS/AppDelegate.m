//
//  AppDelegate.m
//  TodoList
//
//  Created by Ankit Mittal on 27/04/15.
//  Copyright (c) 2015 Inmobi. All rights reserved.
//

#import "AppDelegate.h"
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

typedef NS_ENUM(NSInteger, IMPrivateLogLevel) {
    kIMPrivateLogLevelNone,
    kIMPrivateLogLevelError,
    kIMPrivateLogLevelDebug,
    kIMPrivateLogLevelInternal
};


@interface IMPublisherProvidedInfo : NSObject
+ (void)setLogLevel:(IMPrivateLogLevel)logLevel;

@end

@interface AppDelegate ()

@end

@implementation AppDelegate


void exceptionHandler (NSException *ex) {
    NSLog(@"stack trace : %@", ex.callStackSymbols);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    NSDictionary* dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"InMobi_com.config.store_ads_config"];
//    NSMutableDictionary* muDict = [NSMutableDictionary dictionaryWithDictionary:dict];
//    [muDict setObject:@"https://i.w.inmobi.com/showad.asm" forKey:@"url"];
//    [[NSUserDefaults standardUserDefaults] setObject:muDict forKey:@"InMobi_com.config.store_ads_config"];
//    
//    [IMSdk initWithAccountID:@"12345678809987654321"];
     [IMSdk initWithAccountID:@"6bc86aa10dce4c359d9f98b4cf193de9"];
//    [IMSdk initWithAccountID:@"6bc86aa10dce4c359d9f98b4cf193de9" consentDictionary:@{IM_GDPR_CONSENT_AVAILABLE:@YES,@"gdpr":@1}]; （欧盟流量必须使用此初始化方法）
    
    
//    12345678809987654321
    
    [IMSdk setLogLevel:kIMSDKLogLevelDebug];
    
    [IMSdk setGender:kIMSDKGenderFemale];
    [IMSdk setAgeGroup:kIMSDKAgeGroupBetween25And29];
    
  //  [IMSdk setAdServerUrl:@"http://im1544-x0.local:9090/1111.json"];
    [IMPublisherProvidedInfo setLogLevel:kIMPrivateLogLevelInternal];
    
    NSString *encryption = @"NO";
    [[NSUserDefaults standardUserDefaults] setObject: encryption forKey:@"im_network_encryption"];
    

  //  [IMSdk setAdServerUrl:@"https://strands-demo.inmobi.com/Video20_server/index.php"];
   //[IMSdk setAdServerUrl:@"http://IM1544-X0.local:9090/video20/php_server/index.php"];
   // [IMSdk setAdServerUrl:@"http://im1544-x0.local:1337/"];
    
 //    [IMSdk setAdServerUrl:@"http://10.14.144.182/showad.asm"];

 //   [IMSdk setAdServerUrl:@"https://i.w.inmobi.com/showad.asm"];
    
//    [IMSdk setIV:@"abcdefghijklmnop"];
//    [IMSdk setAESKey:@"abcdefghijklmnop"];
    
    // Uncomment to change the background color of navigation bar
     [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x505A5B)];
    
    // Uncomment to change the color of back button
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    // Uncomment to assign a custom background image
   //  [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7.png"] forBarMetrics:UIBarMetricsDefault];
    
    // Uncomment to change the back indicator image
    /*
     [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"back_btn.png"]];
     [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back_btn.png"]];
     */
    
    // Uncomment to change the font style of the title
    
     NSShadow *shadow = [[NSShadow alloc] init];
     shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
     shadow.shadowOffset = CGSizeMake(0, 1);
     [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
     [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
     shadow, NSShadowAttributeName,
     [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
