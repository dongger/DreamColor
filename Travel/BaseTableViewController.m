//
//  BaseTableViewController.m
//  Travel
//
//  Created by caiyang on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "BaseTableViewController.h"
#import "UIColor+Hex.h"
#import <RTRootNavigationController.h>

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
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"#2685d7"]];
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"back_arrow_white"]];
    
    if (self.rt_navigationController.rt_viewControllers.count > 1) {
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
        [backButton setImage:[UIImage imageNamed:@"back_arrow_white"] forState:UIControlStateNormal];
        [backButton setContentEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        [self.navigationItem setLeftBarButtonItem:item];
    }
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
