//
//  UserModel.m
//  Travel
//
//  Created by caiyang on 2017/5/9.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

/**
 *  登录
 */
+ (void)login:(NSDictionary*)parameters
    success:(void(^)(User* user))successBlock
    failure:(void(^)(NSString * errorMessage))failueBlock {
    [NetWorkTool POST:__login parameters:parameters success:^(NSDictionary * _Nullable dictionary) {
        User *user = [User yy_modelWithJSON:dictionary];
        successBlock(user);
    } failure:^(NSString * _Nullable errorMessage) {
        failueBlock(errorMessage);
    }];
}

@end
