//
//  UserModel.m
//  Travel
//
//  Created by caiyang on 2017/5/9.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel


//func peopleInfo(orderid: Int, _ completion: Completion? = nil) {
//    let parms :[String: Any] = ["orderId": orderid]
//    NetworkTool.GET(ApiNameStruct.settlementUser, parameters:parms,successHandler: { (result) in
//        completion?(result ,nil)
//    }) { (error) in
//        completion?(nil ,error)
//    }
//    
//}

/**
 *  get请求
 *
 *  @param urlString    url
 *  @param parameters   参数
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)login:(NSString*)urlString
 parameters:(NSDictionary*)parameters
    success:(void(^)(NSDictionary* dictionary))successBlock
    failure:(void(^)(NSError * _Nonnull error))failueBlock {

    
    
    
//    [netManager GET:urlString parameters:[NetWorkTool addPublicParametersTo:parameters] progress:^(NSProgress * _Nonnull downloadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        if (successBlock) {
//            successBlock(dic);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (failueBlock) {
//            failueBlock(error);
//        }
//    }];
}


@end
