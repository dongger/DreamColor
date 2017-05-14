//
//  OrderList.m
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "OrderList.h"

@implementation OrderList

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"Orders" : [Order class]};
}

@end
