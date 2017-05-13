//
//  CitiesModel.m
//  Travel
//
//  Created by caiyang on 2017/5/10.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "CitiesModel.h"
#import "CitiesGroup.h"

@implementation CitiesModel

+ (void)fetchWithSuccess: (void(^)(NSArray* citiesData))successBlock
                 failure: (void(^)(NSString * errorMessage))failueBlock {
    [NetWorkTool POST:__getCities parameters:nil success:^(id responseObject, NSInteger code) {
        successBlock([NSArray yy_modelArrayWithClass:[CitiesGroup class] json:responseObject]);
    } failure:^(NSString * _Nullable errorMessage, NSInteger code) {
        failueBlock(errorMessage);
    }];
}

@end
