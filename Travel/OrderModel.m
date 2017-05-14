//
//  OrderModel.m
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

//订单列表
+ (void)orderListWithPage: (NSInteger)pageIndex
                  success: (void(^)(OrderList* orderList, NSInteger code))successBlock
                  failure: (void(^)(NSString * _Nullable errorMessage, NSInteger code))failueBlock {
    NSDictionary *parameters = @{@"PageIndex": @(pageIndex)};
    [NetWorkTool POST:__orderList parameters:parameters success:^(id responseObject, NSInteger code) {
        if (responseObject) {
            successBlock([OrderList yy_modelWithJSON:responseObject], code);
        } else {
            successBlock(nil, code);
        }
    } failure:^(NSString * _Nullable errorMessage, NSInteger code) {
        failueBlock(errorMessage, code);
    }];
}

//订单详情
+ (void)detailForOrderId: (NSString *)orderId
                 success: (void(^)(Order* order, NSInteger code))successBlock
                 failure: (void(^)(NSString * _Nullable errorMessage, NSInteger code))failueBlock {
    NSDictionary *parameters = @{@"OrderId": orderId};
    [NetWorkTool POST:__orderDetail parameters:parameters success:^(id responseObject, NSInteger code) {
        if (responseObject) {
            successBlock([Order yy_modelWithJSON:responseObject], code);
        } else {
            successBlock(nil, code);
        }
    } failure:^(NSString * _Nullable errorMessage, NSInteger code) {
        failueBlock(errorMessage, code);
    }];
}

@end
