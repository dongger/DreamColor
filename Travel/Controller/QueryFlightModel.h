//
//  QueryFlightModel.h
//  Travel
//
//  Created by caiyang on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkTool.h"
#import <YYModel.h>

@interface QueryFlightModel : NSObject

+ (void)fetchWithStartCityCode: (NSString *)startCode
           destinationCityCode: (NSString *)destinationCode
                          date: (NSDate *)date
                      bookType: (NSInteger)bookType
                    travelType: (NSInteger)travelType
                       success: (void(^)(id responseObject))successBlock
                       failure: (void(^)(NSString * errorMessage))failueBlock;

@end
