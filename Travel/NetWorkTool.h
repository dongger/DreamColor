//
//  NetWorkTool.h
//  Travel
//
//  Created by caiyang on 2017/5/9.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLConfig.h"

@interface NetWorkTool : NSObject

/**
 *  get请求
 *
 *  @param urlString    url
 *  @param parameters   参数
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GET:(NSString*_Nonnull)urlString
 parameters:(NSDictionary*_Nullable)parameters
    success:(void(^_Nullable)(NSDictionary* _Nullable dictionary))successBlock
    failure:(void(^_Nullable)(NSString * _Nullable errorMessage))failueBlock;

/**
 *  post请求
 *
 *  @param urlString    url
 *  @param parameters   参数
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+ (void)POST:(NSString*_Nonnull)urlString
  parameters:(NSDictionary*_Nullable)parameters
     success:(void(^_Nullable)(id _Nullable responseObject))successBlock
     failure:(void(^_Nullable)(NSString * _Nullable errorMessage))failueBlock;

/**
 *  图片上传
 */
+(void)postUploadWithUrl:(NSString *_Nonnull)urlStr
              parameters:(id _Nullable )parameters
                fileData:(NSData *_Nullable)fileData
                    name:(NSString *_Nullable)name
                fileName:(NSString *_Nullable)fileName
                fileType:(NSString *_Nullable)fileType
                 success:(void (^_Nullable)(id _Nullable responseObject))success
                    fail:(void (^_Nullable)())fail;
/**
 *  多张图片上传
 */
+(void)postUploadWithUrl:(NSString *_Nonnull)urlStr
            uploadImages:(NSArray *_Nullable)images
              completion:(void(^_Nullable)(NSString * _Nullable url,NSError * _Nullable error))uploadBlock
             andPramaDic:(NSDictionary *_Nullable)paramaDic;

@end
