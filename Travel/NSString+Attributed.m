//
//  NSString+AttributedString.m
//  Travel
//
//  Created by yang cai on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "NSString+Attributed.h"

@implementation NSString (Attributed)

- (NSAttributedString *)setColor: (UIColor *)color
                            font: (UIFont *)font
                    forSubString: (NSString *)subString {
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:self];
    NSRange range = [self rangeOfString:subString];
    if (range.location == NSNotFound) {
        return attrStr;
    }
    //设置字体
    [attrStr addAttribute:NSFontAttributeName value: font range:range];
    //添加文字颜色
    [attrStr addAttribute:NSForegroundColorAttributeName value:color range: range];
    return attrStr;
}

@end
