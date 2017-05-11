//
//  Cabin.h
//  Travel
//
//  Created by caiyang on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Cabin : NSObject

@property NSString *Key;
@property NSString *CabinCode;
@property NSString *CabinName;
@property NSString *CabinType;
@property NSInteger CabinDiscount; //折扣
@property NSInteger Surplus; //剩余座位数
@property CGFloat MinRefundFee;
@property NSString *PriceSource;
@property CGFloat SalePrice; //销售价
@property CGFloat TicketPrice; //票面价

@end
