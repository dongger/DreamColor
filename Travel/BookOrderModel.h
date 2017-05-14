//
//  BookOrderModel.h
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkTool.h"
#import <YYModel.h>
#import "BookOrderEntity.h"

@interface BookOrderModel : NSObject

+ (void)bookWithEntity: (BookOrderEntity *_Nonnull)entity
               success: (void(^_Nullable)(NSString* _Nullable orderId, NSInteger code))successBlock
               failure: (void(^_Nullable)(NSString * _Nullable errorMessage, NSInteger code))failueBlock;

@end
