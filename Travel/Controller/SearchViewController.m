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
        
        
        NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [dateFormatter setTimeZone:GTMzone];

        NSString *takeoffDate = [dateFormatter stringFromDate:_searchDate];
        _dateLabel.text = takeoffDate;

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
    [QueryFlightModel fetchWithStartCityCode:_startCity.Code
                         destinationCityCode:_destinationCity.Code
                                        date:_searchDate
                                    bookType:_bookType
                                  travelType:_travelType
                                     success:^(id responseObject) {
        
                                         
                                         
    } failure:^(NSString *errorMessage) {
        
    }];
}

@end
