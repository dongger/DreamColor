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

+ (void)login:(NSString*)urlString
   parameters:(NSDictionary*)parameters
      success:(void(^)(User* user))successBlock
      failure:(void(^)(NSString * errorMessage))failueBlock;

@end
