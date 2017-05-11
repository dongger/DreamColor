//
//  QueryFlightResult.m
//  Travel
//
//  Created by caiyang on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "QueryFlightResult.h"

@implementation QueryFlightResult

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"Flights" : [Flight class]};
}

@end
