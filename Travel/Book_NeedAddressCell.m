//
//  Book_NeedAddressCell.m
//  Travel
//
//  Created by yang cai on 2017/5/13.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "Book_NeedAddressCell.h"


@interface Book_NeedAddressCell()
@property SwitchBlock block;
@property (weak, nonatomic) IBOutlet UISwitch *needSwtich;


@end

@implementation Book_NeedAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)loadInfo: (BOOL)need
           block: (void(^_Nullable)(BOOL need))block {
    _block = block;
    [_needSwtich setOn:need];
}

- (IBAction)valueChanged:(UISwitch *)sender {
    _block(sender.on);
}

@end
