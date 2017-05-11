//
//  QueryFlightResult.h
//  Travel
//
//  Created by caiyang on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Flight.h"

@interface QueryFlightResult : NSObject

@property NSArray *TimePeriods; //时间段范围筛选条件列表，列表 项为字符串类型:上午、下午、晚上
@property NSArray *Airlines; //航空公司筛选条件列表，列表项为:航空公司二字码字符串
@property NSArray *CabinLevels; //舱位级别筛选条件列表，列表项 为字符串类型:公务舱、经济舱、 头等舱
@property NSArray *Flights; //航班信息

@end
