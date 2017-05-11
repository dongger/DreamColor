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
    _bookType = 1;
    _travelType = 1;
}

- (IBAction)pickDate:(id)sender {
    CalendarViewController *calendar = [CalendarViewController instance:^(NSDate * _Nullable date) {
        NSLog(@"%@", [date description]);
        _searchDate = date;
        _dateLabel.text = [_searchDate convertWith:@"yyyy-MM-dd"];

    }];
    [self.navigationController pushViewController:calendar animated:YES];
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
    SearchResultViewController *vc = [SearchResultViewController instance];
    vc.startCity = _startCity;
    vc.destinationCity = _destinationCity;
    vc.searchDate = _searchDate;
    vc.bookType = _bookType;
    vc.travelType = _travelType;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
