//
//  RNSington.m
//  sxbapp
//
//  Created by 蔡留洋 on 2017/6/12.
//  Copyright © 2017年 蔡留洋. All rights reserved.
//

#import "RNSington.h"

@implementation RNSington
+ (instancetype)sharedReactNative
{
    static RNSington *_rington = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _rington = [[self alloc] init];
    });
    return _rington;
}
@end
