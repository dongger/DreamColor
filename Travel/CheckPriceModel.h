//
//  CheckPriceModel.h
//  Travel
//
//  Created by yang cai on 2017/5/13.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkTool.h"
#import <YYModel.h>
#import "CheckPriceResult.h"

@interface CheckPriceModel : NSObject

+ (void)checkWithFlightKey: (NSString *)flightKey
                  cabinKey: (NSString *)cabinKey
                   success: (void(^)(CheckPriceResult* result, NSInteger code))successBlock
                   failure: (void(^)(NSString * _Nullable errorMessage, NSInteger code))failueBlock;

@end
