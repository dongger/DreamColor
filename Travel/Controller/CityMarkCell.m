//
//  CityMarkCell.m
//  Travel
//
//  Created by caiyang on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "CityMarkCell.h"

@interface CityMarkCell()

@end

@implementation CityMarkCell
- (void)awakeFromNib {
    [super awakeFromNib];
    _background.layer.borderColor = [[UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1] CGColor];
    _background.layer.borderWidth = 1;
}

@end
