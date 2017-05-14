//
//  OrderPayPassengerCell.m
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "OrderPayPassengerCell.h"
#import "NSString+Attributed.h"
#import "UIColor+Hex.h"

@interface OrderPayPassengerCell()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *titleMark;


@end

@implementation OrderPayPassengerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadInfo: (Passenger *)passenger
       needTitle: (BOOL) isNeed {
    NSString *nameString = [NSString stringWithFormat:@"%@    %@", passenger.Name,passenger.Department];
    _name.attributedText = [nameString setColor:[UIColor colorWithHexString:@"#bbbbbb"] font:_name.font forSubString:passenger.Department];
    
    _num.text = [NSString stringWithFormat:@"%@  %@",passenger.IdTypeName, passenger.IdNumber];
    [_titleMark setHidden:!isNeed];
}

@end
