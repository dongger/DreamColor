//
//  FirstViewController.m
//  DreamColor
//
//  Created by caiyang on 2017/5/8.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "FirstViewController.h"
#import "UserModel.h"
#import "LoginUser.h"
#import "NSObject+Cache.h"
#import "CyAlertView.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

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
