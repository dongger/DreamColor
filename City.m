//
//  City.m
//  Travel
//
//  Created by caiyang on 2017/5/10.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "City.h"
#import "NSObject+Cache.h"

@implementation City

- (void)cacheToHistory {
    NSMutableArray *history = [[NSMutableArray alloc] initWithArray:[City getArrayFromKey:@"kCitiesHistory"]];
    for (City *historyCity in history) {
        if ([historyCity.CityName isEqualToString:self.CityName]) {
            return;
        }
    }
    if (history.count == 3) {
        [history removeObjectAtIndex:0];
    }
    [history addObject:self];
    [history saveWithKey:@"kCitiesHistory"];
}

@end
