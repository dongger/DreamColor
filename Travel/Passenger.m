//
//  Passenger.m
//  Travel
//
//  Created by caiyang on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "Passenger.h"

@implementation Passenger

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    switch (self.IdType) {
        case 0:
            self.IdTypeName = @"身份证";
            break;
        case 1:
            self.IdTypeName = @"护照";
            break;
        default:
            self.IdTypeName = @"其他";
            break;
    }
    return YES;
}

@end
