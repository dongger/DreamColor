//
//  OrderPayPassengerCell.h
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Passenger.h"

@interface OrderPayPassengerCell : UITableViewCell

- (void)loadInfo: (Passenger *)passenger
       needTitle: (BOOL) isNeed;

@end
