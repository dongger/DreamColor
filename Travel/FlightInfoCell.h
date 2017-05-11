//
//  FlightInfoCell.h
//  Travel
//
//  Created by yang cai on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flight.h"

@interface FlightInfoCell : UITableViewCell
- (void)loadInfo: (Flight *)flight;
@end
