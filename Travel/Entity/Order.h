//
//  Order.h
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Passenger.h"
#import <UIKit/UIKit.h>

@interface Order : NSObject

@property NSString *TakeoffCityName;
@property NSString *TakeoffAirportName;
@property NSString *TakeoffCityCode;
@property NSString *TakeoffTerm;
@property NSString *ArriveCityName;
@property NSString *ArriveAirportName;
@property NSString *ArriveCityCode;
@property NSString *ArrivalTerm;
@property NSString *FlipCity;
@property NSString *OrderId;
@property NSInteger OrderStatus; //订单状态 新订单等待支付 = 0, 已支付待出票 = 1, 出票成功交易结束 = 2, 已取消 = 3
@property NSString *OrderStatusString;
@property NSString *OrderStatusColor;

@property NSInteger BookMode; //预订类型 直客 = 0, 因公 = 1, 因私 = 2
@property NSString *CreateDate;
@property CGFloat SettlePrice; //订单结算价
@property NSString *TakeOffDate;
@property NSString *ArrivalDate;
@property NSString *Airline;
@property NSString *AirlineName;
@property NSString *FligthNo;
@property NSString *PlaneModel;
@property NSString *CabinCode;
@property NSString *CabinType;
@property NSInteger CabinDiscount;
@property NSString *LinkName;
@property NSString *LinkPhone;
@property CGFloat AirportFee; //单人机建费
@property CGFloat FuelFee; //单人燃油费
@property CGFloat SingleSettlePrice; //单人结算价
@property CGFloat InsPrice; //单人保险
@property NSString *LastPayTime;
@property NSArray *Passengers;

@end
