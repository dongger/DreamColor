//
//  NSString+Check.h
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Check)

/**
 * 身份证号全校验
 */
- (BOOL)verifyIDCardNumber;

/**
 * 手机号校验
 */
- (BOOL)valiMobile;

@end
