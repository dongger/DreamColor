//
//  BaseViewController.m
//  Travel
//
//  Created by yang cai on 2017/5/9.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "BaseViewController.h"
#import "UIColor+Hex.h"
#import <RTRootNavigationController.h>

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"#2685d7"]];
    
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
