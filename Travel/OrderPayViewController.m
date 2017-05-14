//
//  OrderPayViewController.m
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "OrderPayViewController.h"
#import "OrderPayTitleView.h"
#import "OrderModel.h"

static CGFloat baseHeightForHeaderView = 150;

@interface OrderPayViewController ()
@property NSString *orderId;
@property Order *order;
@property BOOL detailIsShow;
@property (weak, nonatomic) IBOutlet UILabel *orderTitle;
@property (weak, nonatomic) IBOutlet UILabel *orderTime;
@property (weak, nonatomic) IBOutlet OrderPayTitleView *titleView;

@end

@implementation OrderPayViewController

+ (OrderPayViewController *)instanceWithOrderId: (NSString *)orderId  {
    OrderPayViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OrderPayViewController"];
    vc.orderId = orderId;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self orderDetail];
    [self initUI];
}

- (void)initUI {
    _detailIsShow = NO;
    UIView *view=self.tableView.tableHeaderView;
    CGFloat newHeight = baseHeightForHeaderView;
    view.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, newHeight);
    self.tableView.tableHeaderView = view;
}

- (void)orderDetail {
    [OrderModel detailForOrderId:_orderId success:^(Order * _Nullable order, NSInteger code) {
        _order = order;
        _orderTitle.text = [NSString stringWithFormat:@"%@%@ 一 %@%@",
                            order.TakeoffCityName,
                            order.TakeoffAirportName,
                            order.ArriveCityName,
                            order.ArriveAirportName];
        [_titleView loadInfo:_order];
    } failure:^(NSString * _Nullable errorMessage, NSInteger code) {
        
    }];
}

- (IBAction)showDetail:(id)sender {
    UIView *view=self.tableView.tableHeaderView;
    CGFloat newHeight = baseHeightForHeaderView;
    if (!_detailIsShow) {
        newHeight = newHeight + [OrderPayTitleView height:_order];
    }
    _detailIsShow = !_detailIsShow;
    UIButton *button = (UIButton *)sender;
    button.selected = _detailIsShow;
    [UIView animateWithDuration:0.3 animations:^{
        view.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, newHeight);
        self.tableView.tableHeaderView = view;
    } completion:^(BOOL finished) {
    }];
}

- (IBAction)pay:(id)sender {
}

@end
