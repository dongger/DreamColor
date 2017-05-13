//
//  Book_InsurancesCell.m
//  Travel
//
//  Created by yang cai on 2017/5/13.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "Book_InsurancesCell.h"

@interface Book_InsurancesCell()
@property (weak, nonatomic) IBOutlet UILabel *content;

@end

@implementation Book_InsurancesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadInfo: (NSInteger )InsKey
      Insurances: (NSArray *)InsurancesArray {
    for (Insurances *insurance in InsurancesArray) {
        if (insurance.ID == InsKey) {
            _content.text = [NSString stringWithFormat:@"%@  %ld",insurance.Name, (long)insurance.Price];
            return;
        }
    }
    _content.text = @"无";
}

@end
