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

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)pickDate:(id)sender {
    CalendarViewController *calendar = [CalendarViewController instance:^(NSDate * _Nullable date) {
        NSLog(@"%@", [date description]);
    }];
    [self.navigationController pushViewController:calendar animated:YES];
}

- (IBAction)pickCity:(id)sender {
    CitiesViewController *citiesVC = [CitiesViewController instance:^(City* _Nullable city) {
        [CyAlertView message:city.CityName];
        [self.navigationController popViewControllerAnimated:YES];

    }];
    [self.navigationController pushViewController:citiesVC animated:YES];
}

@end
