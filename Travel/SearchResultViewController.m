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

@interface SearchResultViewController ()<UITableViewDataSource, UITableViewDelegate>
@property QueryFlightResult* result;
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

- (void)fetchData {
    [QueryFlightModel fetchWithStartCityCode:_startCity.Code
                         destinationCityCode:_destinationCity.Code
                                        date:_searchDate
                                    bookType:_bookType
                                  travelType:_travelType
                                     success:^(QueryFlightResult* result)
     {
         _result = result;
         [self.tableView reloadData];
     } failure:^(NSString *errorMessage) {
         
     }];
}

- (IBAction)filtrate:(id)sender {
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
