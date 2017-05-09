//
//  LoginTypeController.m
//  Travel
//
//  Created by yang cai on 2017/5/9.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "LoginTypeController.h"
#import "LoginViewController.h"

@interface LoginTypeController ()

@end

@implementation LoginTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
}

- (IBAction)personalUser:(id)sender {
    LoginViewController *loginView = [LoginViewController instanceIsEnterprise:NO];
    [self.navigationController pushViewController:loginView animated:YES];
}

- (IBAction)EnterpriseLogincc:(id)sender {
    LoginViewController *loginView = [LoginViewController instanceIsEnterprise:YES];
    [self.navigationController pushViewController:loginView animated:YES];
}

@end
