//
//  OrderModel.h
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkTool.h"
#import <YYModel.h>
#import "Order.h"

@interface OrderModel : NSObject

+ (void)detailForOrderId: (NSString *_Nonnull)orderId
                 success: (void(^_Nullable)(Order* _Nullable order, NSInteger code))successBlock
                 failure: (void(^_Nullable)(NSString * _Nullable errorMessage, NSInteger code))failueBlock;

@end
