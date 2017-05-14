//
//  PayModel.h
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkTool.h"
#import <YYModel.h>

@interface PayModel : NSObject

//获取支付方式
+ (void)typesForOrderId: (NSString *_Nonnull)orderId
                success: (void(^)(NSArray *types, NSInteger code))successBlock
                failure: (void(^_Nullable)(NSString * _Nullable errorMessage, NSInteger code))failueBlock;

//发起支付
+ (void)payForOrderId: (NSString *_Nonnull)orderId
              payType: (NSString *)payType
              success: (void(^_Nullable)(NSString * _Nullable AlipayWapForm, NSInteger code))successBlock
              failure: (void(^_Nullable)(NSString * _Nullable errorMessage, NSInteger code))failueBlock;

@end
