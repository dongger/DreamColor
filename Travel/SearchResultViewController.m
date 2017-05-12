//
//  SearchResultViewController.m
//  Travel
//
//  Created by yang cai on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "SearchResultViewController.h"
#import "FlightInfoCell.h"
#import "QueryFlightModel.h"
#import "FiltrateViewController.h"
#import "FiltrateViewController.h"
#import "NSObject+Cache.h"

static NSString *saveKey = @"kQueryFlightResult";

@interface SearchResultViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSInteger selectedRow;

@end


@implementation SearchResultViewController

+ (SearchResultViewController *)instance {
    SearchResultViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SearchResultViewController"];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedRow = -1;
    [self fetchData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self filtrate];
}

- (void)filtrate {
    if (_result != nil && _selectedFiltrateArray.count == 3) {
        [self getCache];
        NSMutableArray *flights = [[NSMutableArray alloc] init];
        for (Flight *flight in _result.Flights) {
            BOOL needShow = YES;
            if ([_selectedFiltrateArray[0] count] > 0) {
                //筛选时间
                if (![_selectedFiltrateArray[0] containsObject:flight.TakeOffDatePeriods]) {
                    needShow = NO;
                    continue;
                }
            }
            if ([_selectedFiltrateArray[1] count] > 0) {
                //筛选航司
                if (![_selectedFiltrateArray[1] containsObject:flight.AirlineName]) {
                    needShow = NO;
                    continue;
                }
            }
            if ([_selectedFiltrateArray[2] count] > 0) {
                //筛选舱位
                NSMutableArray *cabins = [[NSMutableArray alloc] init];
                for (Cabin *cabin in flight.Cabins) {
                    if ([_selectedFiltrateArray[2] containsObject: cabin.CabinType]) {
                        [cabins addObject:cabin];
                    }
                }
                if (cabins.count > 0) {
                    flight.Cabins = cabins;
                } else {
                    needShow = NO;
                    continue;
                }
            }
            if (needShow) {
                [flights addObject:flight];
            }
        }
        _result.Flights = flights;
        [_tableView reloadData];
    }
}

- (void)fetchData {
    [QueryFlightModel fetchWithStartCityCode:_startCity.Code
                         destinationCityCode:_destinationCity.Code
                                        date:_searchDate
                                    bookType:_bookType
                                  travelType:_travelType
                                     success:^(QueryFlightResult* result)
     {
         if (_result == nil) {
             _selectedFiltrateArray = [[NSMutableArray alloc]
                                       initWithObjects:
                                       [NSMutableArray arrayWithArray:@[]],
                                       [NSMutableArray arrayWithArray:@[]],
                                       [NSMutableArray arrayWithArray:@[]],nil];
         }
         _result = result;
         [_result saveWithKey: saveKey];
         [self.tableView reloadData];
     } failure:^(NSString *errorMessage) {
         
     }];
}

- (void)getCache {
    if ([QueryFlightResult getFromKey:saveKey] != nil) {
        _result = [QueryFlightResult getFromKey:saveKey];
        _selectedRow = -1;
        [_tableView reloadData];
    }
}

- (IBAction)filtrate:(id)sender {
    FiltrateViewController *vc = [FiltrateViewController instanceWithdelegate:self];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)sortedByTakeOffDate {
    _result.Flights = [_result.Flights sortedArrayUsingComparator:^NSComparisonResult(Flight * _Nonnull obj1, Flight *  _Nonnull obj2) {
        return [obj1.TakeOffDate compare:obj2.TakeOffDate];
    }];
    _selectedRow = -1;
    [self.tableView reloadData];
}

- (IBAction)sortedByPrice {
    _result.Flights = [_result.Flights sortedArrayUsingComparator:^NSComparisonResult(Flight * _Nonnull obj1, Flight *  _Nonnull obj2) {
        return [@(obj1.LowestPrice) compare: @(obj2.LowestPrice)];
    }];
    _selectedRow = -1;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _result.Flights.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FlightInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FlightInfoCell" forIndexPath:indexPath];
    Flight *flight = _result.Flights[indexPath.row];
    [cell loadInfo:flight];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectedRow == indexPath.row) {
        Flight *flight = _result.Flights[indexPath.row];
        return [FlightInfoCell heightOfCabinsCount:flight.Cabins.count];
    } else {
        return [FlightInfoCell heightOfCabinsCount:0];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectedRow == indexPath.row) {
        _selectedRow = -1;
    } else {
        _selectedRow = indexPath.row;
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
@end
