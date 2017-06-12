//
//  CommonUtility.h
//  sxbapp
//
//  Created by 蔡留洋 on 2017/6/5.
//  Copyright © 2017年 蔡留洋. All rights reserved.
//

#import <Foundation/Foundation.h>

//字符串处理
inline static NSString *StringValue(NSObject *value)
{
    if ([value isKindOfClass:[NSNull class]]|| value == nil) {
        return  @"";
    }else if ([value isKindOfClass:[NSNumber class]]) {
        return  [NSString stringWithFormat:@"%@",[value description]];
    }else if([value isKindOfClass:[NSString class]]){
        return (NSString *)value;
    }else{
        return @"";
    }
    return @"";
}

@interface CommonUtility : NSObject
/**
 *将字典或者数组转成json
 */
+ (NSString*)dicOrArrayToJson:(id)data;
/**
 *json字符串转对象
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
/**
 *对象转json字符串
 */
+ (NSString*)DataTOjsonString:(id)object;
@end
