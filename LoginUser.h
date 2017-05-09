//
//  LoginUser.h
//  Travel
//
//  Created by caiyang on 2017/5/9.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface LoginUser : User

//获取登录用户
+(User *)share;

//设置登录用户
+(void)loadInfo: (User *)user;

@end
