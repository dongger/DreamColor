//
//  UserModel.h
//  Travel
//
//  Created by caiyang on 2017/5/9.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkTool.h"
#import "User.h"
#import <YYModel.h>

@interface UserModel : NSObject

//个人用户
+ (void)login:(NSDictionary*)parameters
      success:(void(^)(User* user))successBlock
      failure:(void(^)(NSString * errorMessage))failueBlock;

//企业用户
+ (void)enterpriseLogin:(NSDictionary*)parameters
                success:(void(^)(User* user))successBlock
                failure:(void(^)(NSString * errorMessage))failueBlock;
@end
