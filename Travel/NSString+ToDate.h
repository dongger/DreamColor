//
//  NSString+ToDate.h
//  Travel
//
//  Created by yang cai on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ToDate)
- (NSDate *)convertWith:(NSString *)format;
@end
