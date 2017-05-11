//
//  Flight.m
//  Travel
//
//  Created by caiyang on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "Flight.h"

@implementation Flight

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"Cabins" : [Cabin class]};
}

@end
