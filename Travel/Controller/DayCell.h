//
//  DayCell.h
//  Travel
//
//  Created by yang cai on 2017/5/10.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayCell : UICollectionViewCell
@property NSDate *cellDate;
- (void)loadInfo: (NSString *)info;
- (void)loadInfo: (NSInteger)day date: (NSDate *)date;
- (BOOL)isEnble: (NSInteger)day date: (NSDate *)date;
@end
