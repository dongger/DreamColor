//
//  OrderFeeDetailCell.m
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "OrderFeeDetailCell.h"

@interface OrderFeeDetailCell()
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *fuelFeeAndAirportFee;
@property (weak, nonatomic) IBOutlet UILabel *insPrice;

@end

@implementation OrderFeeDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadInfo: (Order *)order {
    
    _price.text = [NSString stringWithFormat:@"￥%0.0f x %lu",order.SingleSettlePrice,(unsigned long)order.Passengers.count];
    
    _fuelFeeAndAirportFee.text = [NSString stringWithFormat:@"￥%0.0f x %lu",order.FuelFee + order.AirportFee,(unsigned long)order.Passengers.count];

    if (order.InsPrice < 0.1) {
        _insPrice.text = @"未购买";
    } else {
        _insPrice.text = [NSString stringWithFormat:@"￥%0.0f x %lu",order.InsPrice,(unsigned long)order.Passengers.count];
    }
}

@end
