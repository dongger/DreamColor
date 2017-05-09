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


@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [UserModel login:@"123123" parameters:@{@"123": @"123"} success:^(User *user) {
        
    } failure:^(NSString *errorMessage) {
        
    }];    
    
    [@{@"uid":@"998", @"name":@"zhangyunpeng"} saveWithKey:@"kLoginUser"];
    [LoginUser loadInfo:[User getFromKey:@"kLoginUser"]];
    
}

@end
