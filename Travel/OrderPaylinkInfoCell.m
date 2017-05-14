//
//  OrderPaylinkInfoCell.m
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "OrderPaylinkInfoCell.h"

@interface OrderPaylinkInfoCell()
@property (weak, nonatomic) IBOutlet UILabel *phone;


@end

@implementation OrderPaylinkInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadInfo: (NSString *)linkName
           phone: (NSString *)linkPhone {
    _phone.text = [NSString stringWithFormat:@"%@（%@）",linkPhone, linkName];
}

@end
