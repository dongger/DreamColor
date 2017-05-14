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

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    switch (self.OrderStatus) {
        case 0:
            self.OrderStatusString = @"待支付";
            self.OrderStatusColor = @"#ff4000";
            break;
        case 1:
            self.OrderStatusString = @"已支付待出票";
            self.OrderStatusColor = @"#2685d7";

            break;
        case 2:
            self.OrderStatusString = @"已出票";
            self.OrderStatusColor = @"#59b200";
            break;
        default:
            self.OrderStatusString = @"已取消";
            self.OrderStatusColor = @"#bbbbbb";
            break;
    }
    return YES;
}

@end
