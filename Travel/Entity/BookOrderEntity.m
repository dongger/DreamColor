//
//  BookOrderEntity.m
//  Travel
//
//  Created by yang cai on 2017/5/13.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "BookOrderEntity.h"

@implementation BookOrderEntity

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"Passengers" : [Passenger class]};
}

@end
