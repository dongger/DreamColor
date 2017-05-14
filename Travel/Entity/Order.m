//
//  Order.m
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "Order.h"

@implementation Order

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"Passengers" : [Passenger class]};
}

@end
