//
//  OrderList.h
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Order.h"

@interface OrderList : NSObject
@property NSInteger PageCount;
@property NSInteger PageSize;
@property NSInteger RecordCount;
@property NSMutableArray *Orders;

@end
