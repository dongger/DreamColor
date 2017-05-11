//
//  SearchResultViewController.m
//  Travel
//
//  Created by yang cai on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "SearchResultViewController.h"
#import "FlightInfoCell.h"

@interface SearchResultViewController ()
@property QueryFlightResult* result;
@end

@implementation SearchResultViewController

+ (SearchResultViewController *)instance: (QueryFlightResult *)result {
    SearchResultViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SearchResultViewController"];
    vc.result = result;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];

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
    return 90;
}
@end
