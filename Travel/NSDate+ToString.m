//
//  NSDate+ToString.m
//  Travel
//
//  Created by yang cai on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "NSDate+ToString.h"

@implementation NSDate (ToString)

- (NSString *)convertWith:(NSString *)format {
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    [dateFormatter setTimeZone:GTMzone];
    return [dateFormatter stringFromDate:self];
}

@end
