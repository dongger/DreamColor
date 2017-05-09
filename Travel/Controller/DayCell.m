//
//  DayCell.m
//  Travel
//
//  Created by yang cai on 2017/5/10.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "DayCell.h"
#import "UIColor+Hex.h"

@interface DayCell ()
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation DayCell


- (void)loadInfo: (NSString *)info {
    self.infoLabel.text = info;
    self.infoLabel.textColor = [UIColor colorWithHexString:@"#bbbbbb"];
}

@end
