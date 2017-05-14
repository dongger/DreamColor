//
//  BookOrderModel.m
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "BookOrderModel.h"

@implementation BookOrderModel

//创建订单
+ (void)bookWithEntity: (BookOrderEntity *)entity
               success: (void(^)(NSString* orderId, NSInteger code))successBlock
               failure: (void(^)(NSString * _Nullable errorMessage, NSInteger code))failueBlock {
    NSData *jsonData = [[entity yy_modelToJSONString] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *parameters = [NSJSONSerialization JSONObjectWithData: jsonData options:NSJSONReadingMutableLeaves error:nil];
    [NetWorkTool POST:__bookOrder parameters:parameters success:^(id responseObject, NSInteger code) {
        if (responseObject) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                successBlock(((NSDictionary *)responseObject)[@"OrderId"], code);
            } else {
                successBlock(nil, code);
            }
        } else {
            successBlock(nil, code);
        }
    } failure:^(NSString * _Nullable errorMessage, NSInteger code) {
        failueBlock(errorMessage, code);
    }];
}

@end
