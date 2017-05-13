//
//  Book_AddressCell.m
//  Travel
//
//  Created by yang cai on 2017/5/13.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "Book_AddressCell.h"

@interface Book_AddressCell()
@property (weak, nonatomic) IBOutlet UILabel *address;

@end

@implementation Book_AddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
