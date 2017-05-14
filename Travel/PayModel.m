//
//  PayModel.m
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "PayModel.h"
#import <UIKit/UIKit.h>

@implementation PayModel

//获取支付方式
+ (void)typesForOrderId: (NSString *)orderId
                success: (void(^)(NSArray *types, NSInteger code))successBlock
                failure: (void(^)(NSString * _Nullable errorMessage, NSInteger code))failueBlock {
    NSDictionary *parameters = @{@"OrderId": orderId};
    [NetWorkTool POST:__getPayType parameters:parameters success:^(id responseObject, NSInteger code) {
        if (responseObject) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSArray *array = (NSArray *)(responseObject[@"PayTypes"]);
                NSMutableArray *typesArray = [[NSMutableArray alloc] init];
                for (int i = 0; i < array.count; i++) {
                    NSString *typeString = [NSString stringWithFormat:@"%@",array[i]];
                    [typesArray addObject: typeString];
                }
                successBlock(typesArray, code);
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

//发起支付
+ (void)payForOrderId: (NSString *)orderId
              payType: (NSString *)payType
              success: (void(^)(NSString *AlipayWapForm, NSInteger code))successBlock
              failure: (void(^)(NSString * _Nullable errorMessage, NSInteger code))failueBlock {
    NSDictionary *parameters = @{@"OrderId": orderId,
                                 @"PayType": payType};
    [NetWorkTool POST:__pay parameters:parameters success:^(id responseObject, NSInteger code) {
        if (code == 0) {
            if ([payType isEqualToString:@"9"]) {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    successBlock(((NSDictionary *)responseObject)[@"AlipayWapForm"], code);
                    return;
                }
            } else {
                successBlock(nil, code);
                return;
            }
        }
        failueBlock(@"支付失败", code);
    } failure:^(NSString * _Nullable errorMessage, NSInteger code) {
        failueBlock(errorMessage, code);
    }];
}

@end
