//
//  CitiesGroup.m
//  Travel
//
//  Created by caiyang on 2017/5/10.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "CitiesGroup.h"
#import "City.h"

@implementation CitiesGroup

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"Cities" : [City class]};
}

@end
