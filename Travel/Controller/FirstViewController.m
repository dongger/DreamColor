//
//  FirstViewController.m
//  DreamColor
//
//  Created by caiyang on 2017/5/8.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "FirstViewController.h"
#import "UserModel.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [UserModel login:@"123123" parameters:@{@"123": @"123"} success:^(User *user) {
        
    } failure:^(NSString *errorMessage) {
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
