//
//  Book_PassengerCell.m
//  Travel
//
//  Created by yang cai on 2017/5/13.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "Book_PassengerCell.h"
#import "NSString+Check.h"

@interface Book_PassengerCell()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *phone;

@end

@implementation Book_PassengerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)delete:(id)sender {
}

- (void)loadInfo:(Passenger *)passenger {
    _name.text = passenger.Name;
    _num.text = [NSString stringWithFormat:@"%@  %@",passenger.IdTypeName, passenger.IdNumber];
    if ([passenger.Phone valiMobile]) {
        _phone.text = [NSString stringWithFormat:@"手机号  %@",passenger.Phone];
    } else {
        _phone.text = @"未填写手机号码";
    }
}

@end
