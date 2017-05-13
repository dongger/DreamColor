//
//  CabinInfoCell.m
//  Travel
//
//  Created by yang cai on 2017/5/12.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "CabinInfoCell.h"
#import "NSString+Attributed.h"
#import "CheckPriceModel.h"
#import "UIView+CurrentVC.h"
#import "CyAlertView.h"
#import "CreatOrderViewController.h"

@interface CabinInfoCell()
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *discount;
@property (weak, nonatomic) IBOutlet UILabel *refundFee;
@property Cabin *cabin;
@property Flight *flight;
@end

@implementation CabinInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)book:(id)sender {
    [CheckPriceModel checkWithFlightKey:_flight.Key cabinKey:_cabin.Key success:^(CheckPriceResult *result, NSInteger code) {
        switch (code) {
            case 20400: {
                //价格发生变化
                NSString *msg = [NSString stringWithFormat:@"新价格为 ￥%0.0f, 是否继续预订？",result.NewPrice];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"价格发生变化"
                                                                               message:msg
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                UIAlertAction *actionBook = [UIAlertAction actionWithTitle:@"继续预订" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    result.PriceChecked = 0;
                    CreatOrderViewController *vc = [CreatOrderViewController instanceWithFlight:_flight cabin:_cabin checkResult:result];
                    [[self currentVC].navigationController pushViewController:vc animated:YES];
                }];
                [alert addAction:actionCancel];
                [alert addAction:actionBook];
                [[self currentVC] presentViewController:alert animated:YES completion:nil];
            }
                break;
            case 20401:
                //航班查询结果失效，需要重新查询
                [CyAlertView message:@"航班查询结果失效，需要重新查询"];
                [[self currentVC].navigationController popViewControllerAnimated:YES];
                break;
            case 20402:
                //验价失败，需要重新选择航班
                [CyAlertView message:@"验价失败，需要重新选择航班"];
                [[self currentVC].navigationController popViewControllerAnimated:YES];
                break;
            default: {
                result.PriceChecked = 1;
                CreatOrderViewController *vc = [CreatOrderViewController instanceWithFlight:_flight cabin:_cabin checkResult:result];
                [[self currentVC].navigationController pushViewController:vc animated:YES];
            }
                break;
        }
    } failure:^(NSString * _Nullable errorMessage, NSInteger code) {
        
    }];

}

- (void)loadInfo: (Cabin *)cabin
          flight: (Flight *)flight {
    _cabin = cabin;
    _flight = flight;
    NSString *moneyString = [NSString stringWithFormat:@"￥ %.0f元", cabin.SalePrice];
    _money.attributedText = [moneyString setColor:_money.textColor font: [UIFont systemFontOfSize:10] forSubString:@"￥"];
    _discount.text = [NSString stringWithFormat:@"%@ %ld 折", cabin.CabinType, (long)cabin.CabinDiscount];
    _refundFee.text = [NSString stringWithFormat:@"退改费 ￥%0.0f 起", cabin.MinRefundFee];
}

@end
