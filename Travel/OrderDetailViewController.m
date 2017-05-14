//
//  OrderDetailViewController.m
//  Travel
//
//  Created by yang cai on 2017/5/15.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderModel.h"
#import "CyAlertView.h"
#import "UIColor+Hex.h"
#import "NSDate+ToString.h"
#import "NSString+ToDate.h"
#import "NSString+Attributed.h"

@interface OrderDetailViewController ()
@property Order *order;

@property (weak, nonatomic) IBOutlet UILabel *bookDate;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UIButton *flightInfo;
@property (weak, nonatomic) IBOutlet UILabel *startDate;
@property (weak, nonatomic) IBOutlet UILabel *endDate;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *startAirport;
@property (weak, nonatomic) IBOutlet UILabel *endAirport;
@property (weak, nonatomic) IBOutlet UILabel *flipMark;
@property (weak, nonatomic) IBOutlet UILabel *flipCity;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *salePrice;
@property (weak, nonatomic) IBOutlet UILabel *personCount;
@property (weak, nonatomic) IBOutlet UILabel *perPrice;
@property (weak, nonatomic) IBOutlet UILabel *insPrice;
@property (weak, nonatomic) IBOutlet UILabel *insTotalPrice;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UILabel *personCountTwo;


@end

@implementation OrderDetailViewController

+ (OrderDetailViewController *)instance: (Order *)order {
    OrderDetailViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OrderDetailViewController"];
    vc.order = order;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadInfo];
    [self fetchDetail];
}

- (void)fetchDetail {
    [OrderModel detailForOrderId:_order.OrderId success:^(Order * _Nullable order, NSInteger code) {
        _order = order;
        [self loadInfo];
        [self.tableView reloadData];
    } failure:^(NSString * _Nullable errorMessage, NSInteger code) {
        [CyAlertView message:errorMessage];
    }];
}

- (void)loadInfo {
    _bookDate.text = [NSString stringWithFormat:@"预订时间：%@",_order.CreateDate];
    _status.text = _order.OrderStatusString;
    _status.textColor = [UIColor colorWithHexString:_order.OrderStatusColor];
    
    [_flightInfo setTitle:[NSString stringWithFormat:@" %@%@ | %@ | %@%ld折",
                           _order.AirlineName,
                           _order.FligthNo,
                           _order.PlaneModel,
                           _order.CabinType,
                           _order.CabinDiscount] forState:UIControlStateNormal];
    
    [_flightInfo setImage:[UIImage imageNamed:[NSString stringWithFormat:@"airline_%@",[_order.Airline lowercaseString]]] forState:UIControlStateNormal];
    _startDate.text = [[_order.TakeOffDate convertWith:@"yyyy-MM-dd HH:mm"] convertWith:@"MM月dd日"];
    _startTime.text = [[_order.TakeOffDate convertWith:@"yyyy-MM-dd HH:mm"] convertWith:@"HH:MM"];
    _startAirport.text = [NSString stringWithFormat:@"%@ %@%@",_order.TakeoffCityName,_order.TakeoffAirportName,_order.TakeoffTerm];

    _endDate.text = [[_order.ArrivalDate convertWith:@"yyyy-MM-dd HH:mm"] convertWith:@"MM月dd日"];
    _endTime.text = [[_order.ArrivalDate convertWith:@"yyyy-MM-dd HH:mm"] convertWith:@"HH:MM"];
    _endAirport.text = [NSString stringWithFormat:@"%@ %@%@",_order.ArriveCityName,_order.ArriveAirportName,_order.ArrivalTerm];

    if (_order.FlipCity.length > 0) {
        [_flipMark setHidden:NO];
        [_flipCity setHidden:NO];

        _flipCity.text = _order.FlipCity;
    } else {
        [_flipMark setHidden:YES];
        [_flipCity setHidden:YES];
    }

    CGFloat otherFee = _order.FuelFee + _order.AirportFee;
    CGFloat insPrice = _order.InsPrice;
    CGFloat priceWithIns = _order.SingleSettlePrice - insPrice;
    
    _salePrice.text = [NSString stringWithFormat:@"票价 ￥%0.0f（%0.0f+%0.0f）",priceWithIns,priceWithIns - otherFee,otherFee];
    _personCount.text = [NSString stringWithFormat:@"x %ld人",_order.Passengers.count];
    _personCountTwo.text = [NSString stringWithFormat:@"x %ld人",_order.Passengers.count];

    
    _perPrice.text = [NSString stringWithFormat:@"￥%0.0f",_order.Passengers.count*priceWithIns];
    
    _insPrice.text = [NSString stringWithFormat:@"保险 ￥%0.0f",_order.InsPrice];
    _insTotalPrice.text = [NSString stringWithFormat:@"￥%0.0f",_order.Passengers.count*_order.InsPrice];
    _totalPrice.text = [NSString stringWithFormat:@"￥%0.0f",_order.SettlePrice];
    
}

@end
