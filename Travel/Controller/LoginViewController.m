//
//  LoginViewController.m
//  Travel
//
//  Created by yang cai on 2017/5/9.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginUser.h"
#import "CyAlertView.h"
#import "UserModel.h"

@interface LoginViewController ()
@property BOOL isEnterprise;
@end

@implementation LoginViewController

+ (LoginViewController *)instanceIsEnterprise: (BOOL)isEnterprise {
    LoginViewController *loginView = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];
    loginView.isEnterprise = isEnterprise;
    return loginView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)login:(id)sender {
    NSDictionary *dic = @{@"Account":@"18628169720",
                          @"Password":@"123456",
                          @"Type":@1};
    
    [UserModel login:dic success:^(User *user) {
        [LoginUser loadInfo:user];
        [CyAlertView message:LoginUser.share.Session];
    } failure:^(NSString *errorMessage) {
        [CyAlertView message:errorMessage];
    }];
}

@end
