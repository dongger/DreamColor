//
//  DayCell.m
//  Travel
//
//  Created by yang cai on 2017/5/10.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "DayCell.h"
#import "UIColor+Hex.h"
#import "NSObject+Cache.h"
#import "NSDate+ToString.h"

static NSString *searchDateKey = @"kSearchDate";

@interface DayCell ()
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIView *mark;
@end

@implementation DayCell

- (void)loadInfo: (NSString *)info {
    self.infoLabel.text = info;
    self.infoLabel.textColor = [UIColor colorWithHexString:@"#bbbbbb"];
    [_mark setHidden:YES];
}

- (void)loadInfo: (NSInteger)day date: (NSDate *)date {
    if ([self isEnble:day date:date]) {
        self.infoLabel.textColor = [UIColor blackColor];
    } else {
        self.infoLabel.textColor = [UIColor colorWithHexString:@"#bbbbbb"];
    }
    self.infoLabel.text = [NSString stringWithFormat:@"%ld",(long)day];
}

- (BOOL)isEnble: (NSInteger)day date: (NSDate *)date  {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags
                                          fromDate: date];
    comp.day = day;
    comp.hour = 23;
    comp.minute = 59;
    comp.second = 59;
    _cellDate = [gregorian dateFromComponents:comp];
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:date];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:date];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    _cellDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:_cellDate];
    
    NSString *selectDate = [NSUserDefaults.standardUserDefaults valueForKey:searchDateKey];
    if ([selectDate isEqualToString:[_cellDate convertWith:@"yyyy-MM-dd"]]) {
        [_mark setHidden:NO];
    } else {
        [_mark setHidden:YES];
    }
    NSDate *lastDate = [[NSDate date] dateByAddingTimeInterval:60*60*24*180];
    if ([[_cellDate earlierDate:[NSDate date]] isEqualToDate:_cellDate] || [[_cellDate laterDate:lastDate] isEqualToDate:_cellDate]) {
        return NO;
    } else {
        return YES;
    }
}


@end
