//
//  UserModel.m
//  Travel
//
//  Created by caiyang on 2017/5/9.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "UserModel.h"
#import "NetWorkTool.h"

@implementation UserModel

/**
 *  登录
 */
+ (void)login:(NSString*)urlString
 parameters:(NSDictionary*)parameters
    success:(void(^)(NSDictionary* dictionary))successBlock
    failure:(void(^)(NSString * errorMessage))failueBlock {

    [NetWorkTool POST:mlllogin parameters:nil success:^(NSDictionary * _Nullable dictionary) {
        successBlock(dictionary);
    } failure:^(NSString * _Nullable errorMessage) {
        failueBlock(errorMessage);
    }];
}


@end
