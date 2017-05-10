//
//  Cache.m
//  Travel
//
//  Created by caiyang on 2017/5/9.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "NSObject+Cache.h"
#import <YYModel.h>

@implementation NSObject (Cache)

-(void)saveWithKey: (NSString *)key {
    NSString *jsonString = [self yy_modelToJSONString];
    [NSUserDefaults.standardUserDefaults setObject:jsonString forKey:key];

}

+(id)getFromKey: (NSString *)key {
    return [self yy_modelWithJSON:[NSUserDefaults.standardUserDefaults valueForKey:key]];
}

+(NSArray *)getArrayFromKey: (NSString *)key {
    NSArray *array = [NSUserDefaults.standardUserDefaults valueForKey:key];
    return [NSArray yy_modelArrayWithClass:self json:array];
}

@end
