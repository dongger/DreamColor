//
//  OrderListViewController.m
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderModel.h"
#import "CyAlertView.h"
#import <MJRefresh.h>
#import "OrderListCell.h"

@interface OrderListViewController ()
@property NSInteger page;
@property OrderList* orderList;
@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _page = 0;
    _orderList = [[OrderList alloc] init];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self fetchOrderList];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMore];
    }];
    [self.tableView.mj_header beginRefreshing];

}

- (void)fetchOrderList {
    _page = 0;
    [OrderModel orderListWithPage:_page success:^(OrderList *orderList, NSInteger code) {
        if (_page + 1 < orderList.PageCount) {
            _page = _page + 1;
            [self.tableView.mj_header endRefreshing];
        } else {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        if (orderList.Orders.count > 0) {
            _orderList = orderList;
            [self.tableView reloadData];
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSString * _Nullable errorMessage, NSInteger code) {
        [self.tableView.mj_header endRefreshing];
        [CyAlertView message:errorMessage];
    }];
}

- (void)loadMore {
    [OrderModel orderListWithPage:_page success:^(OrderList *orderList, NSInteger code) {
        if (orderList.Orders.count > 0) {
            if (_page + 1 < orderList.PageCount) {
                _page = _page + 1;
                [self.tableView.mj_footer endRefreshing];
            } else {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [_orderList.Orders addObjectsFromArray:orderList.Orders];
            [self.tableView reloadData];
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSString * _Nullable errorMessage, NSInteger code) {
        [self.tableView.mj_footer endRefreshing];
        [CyAlertView message:errorMessage];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _orderList.Orders.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderListCell" forIndexPath:indexPath];
    Order *order = _orderList.Orders[indexPath.row];
    [cell loadInfo:order];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Order *order = _orderList.Orders[indexPath.row];
    return [OrderListCell height:order];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

@end
