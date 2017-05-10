//
//  MonthCell.h
//  Travel
//
//  Created by yang cai on 2017/5/10.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarViewController.h"

@interface MonthCell : UITableViewCell
@property NSDate *startDate;
@property (weak) CalendarViewController *calendar;
- (void)loadDate: (NSDate *)date;
+ (CGFloat)heightOfDate: (NSDate *)date;
@end
