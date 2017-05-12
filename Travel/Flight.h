//
//  Flight.h
//  Travel
//
//  Created by caiyang on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Cabin.h"

@interface Flight : NSObject

@property NSString *Key;
@property CGFloat AirportFee;
@property NSString *ArrivalDate;
@property NSString *ArrivalTerm; //到达航站楼
@property NSString *Airline; //航空公司二字码
@property NSString *AirlineName; //航空公司名称
@property NSString *TakeOffDate;
@property NSString *TakeoffTerm; //出发航站楼
@property NSArray *Cabins; //舱位信息
@property NSString *FligthNo;

@property NSString *FlipCity; //经停城市，为空表示没有经停
@property NSString *PlaneModel; //机型
@property NSString *TakeoffAirportName; //出发机场名字
@property NSString *TakeoffCityCode;
@property NSString *TakeoffCityName;
@property CGFloat FuelFee; //燃油费
@property CGFloat LowestPrice; //最低售价
@property NSString *ArriveAirportName;
@property NSString *ArriveCityCode;
@property NSString *ArriveCityName;

@property NSString *TakeOffDatePeriods; //起飞时间所属时间段范围


@end
