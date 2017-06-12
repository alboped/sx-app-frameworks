//
//  UserInfo.h
//  sxbapp
//
//  Created by 蔡留洋 on 2017/6/5.
//  Copyright © 2017年 蔡留洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject<NSCoding>
@property(nonatomic,copy)NSString *token;
//预计优化添加
@property(nonatomic,copy)NSString *loginName;
- (instancetype)initWithAttributes:(NSDictionary *)attributes;
@end
