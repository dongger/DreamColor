//
//  CalendarViewController.m
//  Travel
//
//  Created by yang cai on 2017/5/10.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "CalendarViewController.h"
#import "MonthCell.h"

@interface CalendarViewController ()
@property NSDate *startDate;
@property NSDate *endDate;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _startDate = [NSDate date];
    _endDate = [NSDate dateWithTimeInterval:60*60*24*180 sinceDate:_startDate];
}

- (NSDate *)cellDateForIndexPath: (NSInteger)section {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags
                                          fromDate:dt];
    comp.day = 1;
    if (comp.month + section < 13) {
        comp.month = comp.month + section;
    } else {
        comp.month = (comp.month + section) - 12;
        comp.year = comp.year + 1;
    }
    return [gregorian dateFromComponents:comp];
}

- (NSInteger)monthForDate: (NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    
    NSInteger iCurYear = [components year];  //当前的年份
    
    NSInteger iCurMonth = [components month];  //当前的月份
    
    NSInteger iCurDay = [components day];  // 当前的号数

    return iCurMonth;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self monthForDate:_endDate] - [self monthForDate:_startDate] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MonthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"monthCell" forIndexPath:indexPath];
    [cell loadDate:[self cellDateForIndexPath:indexPath.section]];
    return cell;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 55)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *components = [calendar components:unitFlags fromDate:[self cellDateForIndexPath:section]];
    
    NSInteger iCurYear = [components year];  //当前的年份
    
    NSInteger iCurMonth = [components month];  //当前的月份
    
    label.text =  [NSString stringWithFormat:@"%ld-%ld",(long)iCurYear,(long)iCurMonth];

    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MonthCell heightOfDate:[self cellDateForIndexPath:indexPath.section]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

@end
