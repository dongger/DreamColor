//
//  NSString+AttributedString.h
//  Travel
//
//  Created by yang cai on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Attributed)
- (NSAttributedString *)setColor: (UIColor *)color
                            font: (UIFont *)font
                    forSubString: (NSString *)subString;
@end
