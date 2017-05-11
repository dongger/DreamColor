//
//  LoginUser.m
//  Travel
//
//  Created by caiyang on 2017/5/9.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "LoginUser.h"
#import <YYModel.h>
#import "NSObject+Cache.h"

static User *loginUser = nil;

@implementation LoginUser


+(User *)share {
    if(loginUser == nil){
        loginUser = [User getFromKey:@"kLoginUser"];
    }
    return loginUser;
}

+(void)loadInfo: (User *)user {
    [user saveWithKey:@"kLoginUser"];
    loginUser = user;
}

+(BOOL)isLogin {
    if (LoginUser.share.Session.length < 1) {
        return NO;
    } else {
        return YES;
    }
}

@end
