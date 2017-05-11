//
//  City.h
//  Travel
//
//  Created by caiyang on 2017/5/10.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property NSString *Code;
@property NSString *Name;
@property NSString *FirstLetter;
@property NSString *Initials;
@property NSString *IsHotCity;
@property NSString *Pinyin;

- (void)cacheToHistory;

@end
