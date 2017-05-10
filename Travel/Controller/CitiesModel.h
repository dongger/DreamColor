//
//  CitiesModel.h
//  Travel
//
//  Created by caiyang on 2017/5/10.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkTool.h"
#import <YYModel.h>

@interface CitiesModel : NSObject
+ (void)fetchWithSuccess: (void(^)(NSArray* citiesData))successBlock
                 failure: (void(^)(NSString * errorMessage))failueBlock;
@end
