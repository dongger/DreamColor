//
//  SearchViewController.m
//  Travel
//
//  Created by yang cai on 2017/5/10.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "SearchViewController.h"
#import <RTRootNavigationController.h>
#import "CalendarViewController.h"
#import "CitiesViewController.h"
#import "CyAlertView.h"
#import "City.h"
#import "QueryFlightModel.h"
#import "SearchResultViewController.h"
#import "NSDate+ToString.h"
#import "NSObject+Cache.h"
#import "NSString+ToDate.h"
#import "NSString+Attributed.h"
#import "UIColor+Hex.h"

static NSString *searchDateKey = @"kSearchDate";

@interface SearchViewController ()
@property City *startCity;
@property City *destinationCity;
@property NSDate *searchDate;
@property NSInteger bookType; //1:普通乘客 2:公务员
@property NSInteger travelType; //1:因公 2:因私
@property (weak, nonatomic) IBOutlet UIButton *startCityButton;
@property (weak, nonatomic) IBOutlet UIButton *destinationCityButton;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    [self.navigationController.navigationBar setHidden:YES];
    _bookType = 1;
    _travelType = 1;
    //默认搜索时间明天
    [self setDate:[[NSDate date] dateByAddingTimeInterval:60*60*24]];
    //设置默认搜索城市
    NSArray *history = [City getArrayFromKey:@"kCitiesHistory"];
    if (history.count > 1) {
        _startCity = history[history.count - 1];
        _destinationCity = history[history.count - 2];
        [_startCityButton setTitle: _startCity.Name forState:UIControlStateNormal];
        [_destinationCityButton setTitle: _destinationCity.Name forState:UIControlStateNormal];
    }
}

- (IBAction)pickDate:(id)sender {
    CalendarViewController *calendar = [CalendarViewController instance:^(NSDate * _Nullable date) {
        [self setDate:date];
    }];
    [self.navigationController pushViewController:calendar animated:YES];
}

- (void)setDate: (NSDate *)date {
    _searchDate = date;
    [[NSUserDefaults standardUserDefaults] setObject:[_searchDate convertWith:@"yyyy-MM-dd"] forKey:searchDateKey];
    NSString *tomorrow = [[[NSDate date] dateByAddingTimeInterval:60*60*24] convertWith:@"yyyy-MM-dd"];
    NSString *searchDateString = [_searchDate convertWith:@"yyyy-MM-dd"];
    if ([tomorrow isEqualToString:searchDateString]) {
        NSString* dateString = [NSString stringWithFormat:@"%@  %@",searchDateString,@"明天"];
        _dateLabel.attributedText = [dateString setColor:[UIColor colorWithHexString:@"bbbbbb"] font:[UIFont systemFontOfSize:12] forSubString:@"明天"];
    } else {
        _dateLabel.text = searchDateString;
    }
}

- (IBAction)pickStartCity:(id)sender {
    CitiesViewController *citiesVC = [CitiesViewController instance:^(City* _Nullable city) {
        [CyAlertView message:city.Name];
        _startCity = city;
        [_startCityButton setTitle: city.Name forState:UIControlStateNormal];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationController pushViewController:citiesVC animated:YES];
}

- (IBAction)pickDestinationCity:(id)sender {
    CitiesViewController *citiesVC = [CitiesViewController instance:^(City* _Nullable city) {
        [CyAlertView message:city.Name];
        _destinationCity = city;
        [_destinationCityButton setTitle: city.Name forState:UIControlStateNormal];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationController pushViewController:citiesVC animated:YES];
}
- (IBAction)queryFlight:(id)sender {
    if (_startCity == nil) {
        [CyAlertView message:@"请选择出发城市"];
        return;
    }
    if (_destinationCity == nil) {
        [CyAlertView message:@"请选择到达城市"];
        return;
    }
    if (_searchDate == nil) {
        [CyAlertView message:@"请选择出发日期"];
        return;
    }
    SearchResultViewController *vc = [SearchResultViewController instance];
    vc.startCity = _startCity;
    vc.destinationCity = _destinationCity;
    vc.searchDate = _searchDate;
    vc.bookType = _bookType;
    vc.travelType = _travelType;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
