//
//  NSString+ToDate.m
//  Travel
//
//  Created by yang cai on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "NSString+ToDate.h"

@implementation NSString (ToDate)

- (NSDate *)convertWith:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [formatter setTimeZone:GTMzone];
    [formatter setDateFormat : format];
    return [formatter dateFromString:self];
}

@end
