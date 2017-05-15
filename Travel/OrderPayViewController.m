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
#import "UIColor+Hex.h"
#import "NSString+Attributed.h"
#import "NSDate+ToString.h"
#import "NSString+ToDate.m"
#import "PayModel.h"
#import "CyAlertView.h"
#import <RTRootNavigationController.h>
#import "SearchResultViewController.h"

static CGFloat baseHeightForHeaderView = 150;

@interface OrderPayViewController ()
@property NSString *orderId;
@property Order *order;
@property BOOL detailIsShow;
@property NSArray *payTypes;
@property NSInteger selectedPayTypeIndex;
@property (weak, nonatomic) IBOutlet UILabel *orderTitle;
@property (weak, nonatomic) IBOutlet UILabel *orderTime;
@property (weak, nonatomic) IBOutlet OrderPayTitleView *titleView;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UILabel *payTime;

@end

@implementation OrderPayViewController

+ (OrderPayViewController *)instanceWithOrderId: (NSString *)orderId  {
    OrderPayViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OrderPayViewController"];
    vc.orderId = orderId;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPayTypes];
    [self orderDetail];
    [self initUI];
}

- (void)initUI {
    _detailIsShow = NO;
    UIView *view=self.tableView.tableHeaderView;
    CGFloat newHeight = baseHeightForHeaderView;
    view.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, newHeight);
    self.tableView.tableHeaderView = view;
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [backButton setImage:[UIImage imageNamed:@"back_arrow_white"] forState:UIControlStateNormal];
    [backButton setContentEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:item];
}

- (void)back {
    if (self.rt_navigationController.rt_viewControllers.count > 1) {
        UIViewController *vc = self.rt_navigationController.rt_viewControllers[self.rt_navigationController.rt_viewControllers.count - 2];
        if ([vc isKindOfClass:[SearchResultViewController class]]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)orderDetail {
    [OrderModel detailForOrderId:_orderId success:^(Order *order, NSInteger code) {
        _order = order;
        _orderTitle.text = [NSString stringWithFormat:@"%@%@ 一 %@%@",
                            order.TakeoffCityName,
                            order.TakeoffAirportName,
                            order.ArriveCityName,
                            order.ArriveAirportName];
        _orderTime.text = [NSString stringWithFormat:@"%@ 起飞", order.TakeOffDate];
        [_titleView loadInfo:_order];
        NSString *totalPriceString = [NSString stringWithFormat:@"￥%0.0f", _order.SettlePrice];
        _totalPrice.attributedText = [totalPriceString setColor:_totalPrice.textColor font:[UIFont systemFontOfSize:12] forSubString:@"￥"];
        NSDate *date = [_order.LastPayTime convertWith:@"yyyy-MM-dd HH:mm"];
        _payTime.text =[NSString stringWithFormat:@"请在%@前完成支付", [date convertWith:@"HH:mm"]];
    } failure:^(NSString * _Nullable errorMessage, NSInteger code) {
        
    }];
}

- (void)getPayTypes {
    _selectedPayTypeIndex = 0;
    [PayModel typesForOrderId:_orderId success:^(NSArray *types, NSInteger code) {
        _payTypes = types;
        [self.tableView reloadData];
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
    if (_orderId && _payTypes) {
        NSString *payType = _payTypes[_selectedPayTypeIndex];
        [PayModel payForOrderId:_orderId payType:payType success:^(NSString *AlipayWapForm, NSInteger code) {
            [CyAlertView message:@"支付成功"];
            if ([payType isEqualToString:@"9"]) {
                //支付宝特殊处理
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSString * _Nullable errorMessage, NSInteger code) {
            [CyAlertView message:errorMessage];
        }];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _payTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *payType = _payTypes[indexPath.row];
    if ([payType isEqualToString:@"9"]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"alipay" forIndexPath:indexPath];
        UIImageView *imageView = [cell viewWithTag:999];
        if (indexPath.row == _selectedPayTypeIndex) {
            [imageView setImage:[UIImage imageNamed:@"radio_button_on"]];
        } else {
            [imageView setImage:[UIImage imageNamed:@"radio_button"]];
        }
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normal" forIndexPath:indexPath];
        UIImageView *imageView = [cell viewWithTag:999];
        if (indexPath.row == _selectedPayTypeIndex) {
            [imageView setImage:[UIImage imageNamed:@"radio_button_on"]];
        } else {
            [imageView setImage:[UIImage imageNamed:@"radio_button"]];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedPayTypeIndex = indexPath.row;
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
