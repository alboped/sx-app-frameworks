//
//  NetworkingManager.m
//  sxbapp
//
//  Created by 蔡留洋 on 2017/6/8.
//  Copyright © 2017年 蔡留洋. All rights reserved.
//

#import "NetworkingManager.h"

@implementation NetworkingManager


+ (NSString *)urlWithURLType:(URLType)type
{
    NSString *url = [self currentURL];
    return [url stringByAppendingString:[self subUrlWithURLType:type]];
}
+ (NSString *)currentURL
{
    return @"http://172.16.136.83:8080";//HTTP测试服务器
}
+ (NSString *)subUrlWithURLType:(URLType)type
{
    switch (type) {
        case URLTYPE_USERLOGIN:
        {
            // 装换撤查询接口
            return @"/user/login";
        }
            break;
            
        default:
            break;
    }
    return @"";
}
//get请求
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(AFHttpSuccess)success failure:(AFHttpFailure)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20.0f;
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 处理请求成功JSON数据(AFN2.0已经做了JSON解析，内部已封装)
        id obj = responseObject;
        NSLog(@"%@",obj);
        if (success) {  // 成功
            success(obj);
        }
        return;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        NSLog(@"请求失败原因:%@",error);
    }];
}
/**
 * 使用 POST 方式发送纯文本内容
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(AFHttpSuccess)success failure:(AFHttpFailure)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20.0f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",nil];
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id obj = responseObject;
        NSLog(@"%@",obj);
        if (success) {  // 成功
            success(obj);
        }
        return;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        NSLog(@"%@",error);
    }];
}
/**
 * 使用 POST 方式可以带图片
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params constructingBodyWithBlock:(AFHttpconstructingBodyWithBlock)block success:(AFHttpSuccess)success failure:(AFHttpFailure)failure;
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",nil];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (formData) {
            block(formData);
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id obj = responseObject;
        if (success) {
            success(obj);
        }
        NSLog(@"%@",obj);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        NSLog(@"%@",error);
    }];
}
@end
