//
//  UINavigationController+Orientation.m
//  InMobiNativeRebootIOS
//
//  Created by Ankit Mittal on 4/19/17.
//  Copyright © 2017 Inmobi. All rights reserved.
//

#import "UINavigationController+Orientation.h"

@interface UINavigationController_Orientation ()

@end

@implementation UINavigationController (Orientation)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

-(BOOL)shouldAutorotate
{
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
