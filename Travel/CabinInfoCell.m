//
//  CabinInfoCell.m
//  Travel
//
//  Created by yang cai on 2017/5/12.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "CabinInfoCell.h"
#import "NSString+Attributed.h"

@interface CabinInfoCell()
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *discount;
@property (weak, nonatomic) IBOutlet UILabel *refundFee;
@property Cabin *cabin;

@end

@implementation CabinInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)book:(id)sender {

}

- (void)loadInfo: (Cabin *)cabin {
    _cabin = cabin;
    NSString *moneyString = [NSString stringWithFormat:@"￥ %.0f元", cabin.SalePrice];
    _money.attributedText = [moneyString setColor:_money.textColor font: [UIFont systemFontOfSize:10] forSubString:@"￥"];
    _discount.text = [NSString stringWithFormat:@"%@ %ld 折", cabin.CabinType, (long)cabin.CabinDiscount];
    _refundFee.text = [NSString stringWithFormat:@"退改费 ￥%0.0f 起", cabin.MinRefundFee];
}

@end
