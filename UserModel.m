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
+ (void)login:(NSString*)urlString
 parameters:(NSDictionary*)parameters
    success:(void(^)(User* user))successBlock
    failure:(void(^)(NSString * errorMessage))failueBlock {
    [NetWorkTool POST:mlllogin parameters:nil success:^(NSDictionary * _Nullable dictionary) {
        User *user = [User yy_modelWithJSON:dictionary];
        successBlock(user);
    } failure:^(NSString * _Nullable errorMessage) {
        failueBlock(errorMessage);
    }];
}

@end
