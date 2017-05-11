//
//  QueryFlightModel.m
//  Travel
//
//  Created by caiyang on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "QueryFlightModel.h"

@implementation QueryFlightModel

//获取航班信息
+ (void)fetchWithStartCityCode: (NSString *)startCode
           destinationCityCode: (NSString *)destinationCode
                          date: (NSDate *)date
                      bookType: (NSInteger)bookType
                    travelType: (NSInteger)travelType
                       success: (void(^)(id responseObject))successBlock
                       failure: (void(^)(NSString * errorMessage))failueBlock {
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:GTMzone];
    NSString *takeoffDate = [dateFormatter stringFromDate:date];
    NSDictionary *parameters = @{@"Takeoff":startCode,
                                 @"Arrive":destinationCode,
                                 @"TakeoffDate":takeoffDate,
                                 @"BookType":@(bookType),
                                 @"TravelType":@(travelType)};
    [NetWorkTool POST:__queryFlight parameters:parameters success:^(id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSString * _Nullable errorMessage) {
        failueBlock(errorMessage);
    }];
}

@end
