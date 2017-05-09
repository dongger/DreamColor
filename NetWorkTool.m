//
//  NetWorkTool.m
//  Travel
//
//  Created by caiyang on 2017/5/9.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "NetWorkTool.h"
#import <AFNetworking.h>
#import <YYModel.h>
#import "LoginUser.h"

//默认请求超时时间
static const NSTimeInterval timeoutInterval = 15.0;

@implementation NetWorkTool

/**
 *  get请求
 *
 *  @param urlString    url
 *  @param parameters   参数
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GET:(NSString*)urlString
 parameters:(NSDictionary*)parameters
    success:(void(^)(NSDictionary* dictionary))successBlock
    failure:(void(^)(NSString * errorMessage))failueBlock {
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    serializer.removesKeysWithNullValues = YES;
    AFHTTPSessionManager *netManager = [AFHTTPSessionManager manager];
    netManager.requestSerializer     = [AFHTTPRequestSerializer serializer];
    netManager.responseSerializer    = [AFHTTPResponseSerializer serializer];
    netManager.requestSerializer.timeoutInterval = timeoutInterval;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,urlString];
    
    [netManager GET:url parameters:[NetWorkTool addPublicParametersTo:parameters] progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            if ([dic[@"Code"]  isEqual: @"0"]) {
                successBlock(dic[@"Data"]);
            } else {
                failueBlock(dic[@"Message"]);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failueBlock) {
            failueBlock(error.localizedDescription);
        }
    }];
}

/**
 *  post请求
 *
 *  @param urlString    url
 *  @param parameters   参数
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+ (void)POST:(NSString*)urlString
  parameters:(NSDictionary*)parameters
     success:(void(^)(NSDictionary* dictionary))successBlock
     failure:(void(^)(NSString * errorMessage))failueBlock {
    AFHTTPSessionManager *netManager   = [AFHTTPSessionManager manager];
    netManager.requestSerializer      = [AFHTTPRequestSerializer serializer];
    netManager.responseSerializer     = [AFHTTPResponseSerializer serializer];
    netManager.requestSerializer.timeoutInterval = timeoutInterval;
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,urlString];
    NSDictionary *dic = @{@"params":  [[NetWorkTool addPublicParametersTo:parameters] yy_modelToJSONString]};
    [netManager POST:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            if ([dic[@"Code"]  isEqual: @"0"]) {
                successBlock(dic[@"Data"]);
            } else {
                failueBlock(dic[@"Message"]);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failueBlock) {
            failueBlock(error.localizedDescription);
        }
    }];
}

/**
 *  图片上传
 */
+(void)postUploadWithUrl:(NSString *)urlStr
              parameters:(id)parameters
                fileData:(NSData *)fileData
                    name:(NSString *)name
                fileName:(NSString *)fileName
                fileType:(NSString *)fileType
                 success:(void (^)(id responseObject))success
                    fail:(void (^)())fail {
    AFJSONResponseSerializer *serializer  = [AFJSONResponseSerializer serializer];
    AFHTTPSessionManager *manager       = [AFHTTPSessionManager manager];
    manager.responseSerializer         = serializer;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    manager.requestSerializer.timeoutInterval = 15;
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:fileType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail();
        }
    }];
    
}

/**
 *  多张图片上传
 */
+(void)postUploadWithUrl:(NSString *)urlStr
            uploadImages:(NSArray *)images
              completion:(void(^)(NSString *url,NSError *error))uploadBlock
             andPramaDic:(NSDictionary *)paramaDic
{
    
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    AFHTTPSessionManager * manager     = [AFHTTPSessionManager manager];
    manager.responseSerializer        = serializer;
    [manager POST:urlStr parameters:paramaDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 添加一个标记 去分图片名称
        for(NSInteger i = 0; i < images.count; i++)
        {
            UIImage * image = [images objectAtIndex: i];
            // 压缩图片
            NSData *data = UIImageJPEGRepresentation(image, 1.0);
            if (data.length>100*1024)
            {
                if (data.length>1024*1024) {//1M以及以上
                    data = UIImageJPEGRepresentation(image, 0.1);
                }else if (data.length>512*1024) {//0.5M-1M
                    data = UIImageJPEGRepresentation(image, 0.5);
                }else if (data.length>200*1024) {//0.25M-0.5M
                    data = UIImageJPEGRepresentation(image, 0.9);
                }
            }
            // 上传的参数名
            NSString *now = [self nowTime:@"yyyyMMddHHmmss"];
            NSString * Name = [NSString stringWithFormat:@"%@%zi",now,i+1];
            // 上传filename
            NSString * fileName = [NSString stringWithFormat:@"%@.jpg", Name];
            
            [formData appendPartWithFileData:data name:Name fileName:fileName mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}


+ (NSDictionary *)addPublicParametersTo: (NSDictionary *)dic {
    NSString *session = LoginUser.share.Session;
    if (session.length < 1) {
        session = @"";
    }
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
    NSDictionary *publicParametersDic = @{@"ApiVersion":[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                                          @"OS":[[UIDevice currentDevice] systemName],
                                          @"OsVersion": [[UIDevice currentDevice] systemVersion],
                                          @"Model":@"44",
                                          @"DeviceID":[[[UIDevice currentDevice] identifierForVendor] UUIDString],
                                          @"Session": session,
                                          @"ChannelID":@"0"};
    [tempDic setValuesForKeysWithDictionary:publicParametersDic];
    return tempDic;
}


//获取当前时区的当前时间
+ (NSString*)nowTime:(NSString*)dateType
{
    NSDate * date = [NSDate date];
    NSDateFormatter *dateformat=[[NSDateFormatter alloc] init];
    //[dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateformat setDateFormat:dateType];
    NSString * newDate= [dateformat stringFromDate:date];
    return newDate;
}

@end
