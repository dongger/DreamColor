//
//  BookOrderEntity.h
//  Travel
//
//  Created by yang cai on 2017/5/13.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Passenger.h"

@interface BookOrderEntity : NSObject

@property NSString *FlightKey;
@property NSString *CabinKey;
@property NSInteger PriceChecked; //是否已验价 0:价格变化，用户同意 1:价格未变化
@property NSString *LinkName;
@property NSString *LinkPhone;
@property NSString *ReimAddress;
@property NSInteger InsKey;
@property NSArray *Passengers;

@end
