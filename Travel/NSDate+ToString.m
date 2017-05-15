//
//  NSDate+ToString.m
//  Travel
//
//  Created by yang cai on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "NSDate+ToString.h"

@implementation NSDate (ToString)

- (NSString *)convertWith:(NSString *)format {
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    [dateFormatter setTimeZone:GTMzone];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)dayName {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitWeekday;
    comps = [calendar components:unitFlags fromDate:self];
    
    NSLog(@"-----------weekday is %ld",(long)[comps weekday]);//在这里需要注意的是：星期日是数字1，星期一时数字2，以此类推。。。

    switch ([comps weekday]) {
        case 1:
            return @"周日";
            break;
        case 2:
            return @"周一";
            break;
        case 3:
            return @"周二";
            break;
        case 4:
            return @"周三";
            break;
        case 5:
            return @"周四";
            break;
        case 6:
            return @"周五";
            break;
        case 7:
            return @"周六";
            break;

        default:
            return @"未知";
            break;
    }
}
@end
