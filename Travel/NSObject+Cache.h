//
//  Cache.h
//  Travel
//
//  Created by caiyang on 2017/5/9.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Cache)

//储存
-(void)saveWithKey: (NSString *)key;
//读取
+(id)getFromKey: (NSString *)key;
//读取数组
+(NSArray *)getArrayFromKey: (NSString *)key;

@end
