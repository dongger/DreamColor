//
//  NetWorkTool.h
//  Travel
//
//  Created by caiyang on 2017/5/9.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

//@property UInt64 UserID;
@property NSInteger Type; //用户类型 1:公务卡企业用户 2:预算单位企业用户 3:集团单位企业用户 4:个人用户
@property NSString *Session;

@property NSString *KfPhone;
@property NSString *LinkName;
@property NSString *LinkPhone;
@property NSString *Address;

@end
