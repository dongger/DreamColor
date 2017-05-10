//
//  MonthCell.m
//  Travel
//
//  Created by yang cai on 2017/5/10.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "MonthCell.h"
#import "DayCell.h"

@interface MonthCell ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property NSArray *titleArray;
@property NSInteger startDay;
@property NSInteger numOfDays;

@end

@implementation MonthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _titleArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
}

- (void)loadDate: (NSDate *)date {
    _startDate = date;
    // 获取代表公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
//    NSDate* dt = ;
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags
                                          fromDate: _startDate];
    _startDay = comp.weekday;
//  获取当前月份有多少天
    NSRange days = [gregorian rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:_startDate];
    _numOfDays = days.length;
    [_collectionView reloadData];
}

+ (CGFloat)heightOfDate: (NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned unitFlags = NSCalendarUnitWeekday;
    NSDateComponents* comp = [gregorian components: unitFlags
                                          fromDate:date];
    NSRange days = [gregorian rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    NSInteger cellCount = comp.weekday + days.length + 7;
    NSLog(@"%ld",(long)cellCount);
    NSInteger row = cellCount/7 + (cellCount%7==0?0:1);
    return row*50;
}

- (BOOL)needShowDay: (NSIndexPath *)indexPath {
    NSInteger startIndex = 7 + _startDay - 1;
    if (indexPath.row - startIndex < _numOfDays && indexPath.row >= startIndex) {
        return YES;
    } else {
        return NO;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _startDay + _numOfDays + 7;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dayCell" forIndexPath:indexPath];
    
    if (indexPath.row < 7) {
        [cell loadInfo:[NSString stringWithFormat:@"%@",_titleArray[indexPath.row]]];
    } else if ([self needShowDay:indexPath]) {
        NSInteger emptyCount = 7 + _startDay - 2;
        [cell loadInfo: (indexPath.row - emptyCount) date:_startDate];
    } else {
        [cell loadInfo:@" "];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 6) {
        NSInteger startIndex = 7 + _startDay - 1;
//        if (indexPath.row < startIndex) {
////            [cell loadInfo:@" "];
//        } else if ((long)indexPath.row - startIndex < _numOfDays) {
//            [cell loadInfo: (indexPath.row - startIndex + 1) date:_startDate];
//        } else {
////            [cell loadInfo:@" "];
//        }
    }
}

@end
