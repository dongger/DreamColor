//
//  SendCodeModel.m
//  Travel
//
//  Created by caiyang on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "SendCodeModel.h"

@implementation SendCodeModel

+ (void)sendWithPhone: (NSString *)phone
                  type: (NSInteger)type
               success: (void(^)())successBlock
                 failure: (void(^)(NSString * errorMessage))failueBlock {
    //验证码类型 1:登彔 2:注册 3:忘记密码 4:修改密码
    NSDictionary *parameters = @{@"Phone": phone,
                                 @"Type": @(type)};
    [NetWorkTool POST:__getCities parameters:parameters success:^(id responseObject, NSInteger code) {
        successBlock();
    } failure:^(NSString * _Nullable errorMessage, NSInteger code) {
        failueBlock(errorMessage);
    }];
}

@end
