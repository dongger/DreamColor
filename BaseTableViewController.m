//
//  BaseTableViewController.m
//  Travel
//
//  Created by caiyang on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "BaseTableViewController.h"
#import "UIColor+Hex.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                 forBarPosition:UIBarPositionAny
                                                     barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"#2685d7"]];
}

@end
