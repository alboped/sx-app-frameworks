//
//  NetworkingManager.h
//  sxbapp
//
//  Created by 蔡留洋 on 2017/6/8.
//  Copyright © 2017年 蔡留洋. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  请求成功后的回调
 */
typedef void (^AFHttpSuccess)(id obj);
/**
 *  请求失败后的回调
 */
typedef void (^AFHttpFailure)(NSError *error);
typedef void (^AFHttpconstructingBodyWithBlock)(id <AFMultipartFormData> formData);
//接口type
typedef NS_ENUM(NSInteger, URLType)
{
    URLTYPE_USERLOGIN,
};
@interface NetworkingManager : NSObject

/**
 * @brief 根据不同接口地址，获取登录或未登录接口url
 * @param type 接口类型
 * @return 返回登录或未登录接口url
 */
+ (NSString *)urlWithURLType:(URLType)type;
+ (NSString *)subUrlWithURLType:(URLType)type;
+ (NSString *)currentURL;
/**
 *  发送一GET请求
 *
 *  @param url    请求路径
 *  @param params 请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(AFHttpSuccess)success failure:(AFHttpFailure)failure;
/**
 *  发送一POST请求
 *
 *  @param url    请求路径
 *  @param params 请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(AFHttpSuccess)success failure:(AFHttpFailure)failure;
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params constructingBodyWithBlock:(AFHttpconstructingBodyWithBlock)block success:(AFHttpSuccess)success failure:(AFHttpFailure)failure;

@end
