//
//  CheckPriceModel.m
//  Travel
//
//  Created by yang cai on 2017/5/13.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "CheckPriceModel.h"

@implementation CheckPriceModel

//验证价格
+ (void)checkWithFlightKey: (NSString *)flightKey
                  cabinKey: (NSString *)cabinKey
                   success: (void(^)(CheckPriceResult* result, NSInteger code))successBlock
                   failure: (void(^)(NSString * _Nullable errorMessage, NSInteger code))failueBlock {
    NSDictionary *parameters = @{@"FlightKey":flightKey,
                                 @"CabinKey":cabinKey};
    [NetWorkTool POST:__checkPrice parameters:parameters success:^(id responseObject, NSInteger code) {
        successBlock([CheckPriceResult yy_modelWithJSON:responseObject], code);
    } failure:^(NSString * _Nullable errorMessage, NSInteger code) {
        failueBlock(errorMessage, code);
    }];
}

@end
