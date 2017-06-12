//
//  RNSington.h
//  sxbapp
//
//  Created by 蔡留洋 on 2017/6/12.
//  Copyright © 2017年 蔡留洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactNativeViewController.h"
@interface RNSington : NSObject
@property (nonatomic, weak) ReactNativeViewController *reactVC;
+ (instancetype)sharedReactNative;
@end
