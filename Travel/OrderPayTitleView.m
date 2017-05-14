//
//  OrderPayTitleView.m
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "OrderPayTitleView.h"
#import "OrderFeeDetailCell.h"
#import "OrderPayPassengerCell.h"
#import "OrderPaylinkInfoCell.h"

@interface OrderPayTitleView()<UITableViewDelegate, UITableViewDataSource>
@property IBOutlet UITableView* tableView;
@property Order *order;

@end

@implementation OrderPayTitleView


- (void)loadInfo: (Order *)order {
    _order = order;
    [_tableView reloadData];
}

+ (CGFloat)height: (Order *)order {
    return 88 + 58*order.Passengers.count + 40;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return _order.Passengers.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        OrderFeeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderFeeDetailCell" forIndexPath:indexPath];
        [cell loadInfo:_order];
        return cell;
    } else if (indexPath.section == 1) {
        OrderPayPassengerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderPayPassengerCell" forIndexPath:indexPath];
        Passenger *passenger = _order.Passengers[indexPath.row];
        [cell loadInfo:passenger needTitle:(indexPath.row == 0)];
        return cell;
    } else {
        OrderPaylinkInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderPaylinkInfoCell" forIndexPath:indexPath];
        [cell loadInfo:_order.LinkName phone:_order.LinkPhone];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 88;
    } else if (indexPath.section == 1) {
        return 58;
    } else {
        return 40;
    }
}

@end
