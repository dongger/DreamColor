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
#import "OrderList.h"

@interface OrderModel : NSObject

//订单列表
+ (void)orderListWithPage: (NSInteger)pageIndex
                  success: (void(^_Nullable)(OrderList* _Nullable orderList, NSInteger code))successBlock
                  failure: (void(^_Nullable)(NSString * _Nullable errorMessage, NSInteger code))failueBlock;

//订单详情
+ (void)detailForOrderId: (NSString *_Nonnull)orderId
                 success: (void(^_Nullable)(Order* _Nullable order, NSInteger code))successBlock
                 failure: (void(^_Nullable)(NSString * _Nullable errorMessage, NSInteger code))failueBlock;

@end
